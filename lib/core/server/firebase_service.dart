import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:tibbi_asi_takibi/model/vaccine.dart';

class FirebaseServise {
  static const String FIREBASE_URL =
      "https://asi-takip-uygulamasi-default-rtdb.firebaseio.com/";

  Future<List<Vaccine>?> getVaccines() async {
    var url = Uri.parse("$FIREBASE_URL/vaccines.json");
    final response = await http.get(url);

    // if (response.statusCode == HttpStatus.ok) {
    //   final jsonModel = json.decode(response.body);
    //   final userList = jsonModel
    //       .map((e) => Vaccine.fromJson(e as Map<String, dynamic>))
    //       .toList()
    //       .cast<Vaccine>();
    //   print(userList);
    //   return userList;
    // } else
    //   return Future.error(response.statusCode);
    final CollectionReference vaccinesRef =
        FirebaseFirestore.instance.collection("Vaccines");

    QuerySnapshot querySnapshot = await vaccinesRef.get();
    if (querySnapshot.docs.isNotEmpty) {
      final vaccineList = querySnapshot.docs
          .map((doc) => Vaccine.fromJson(doc.data() as Map<String, dynamic>))
          .toList()
          .cast<Vaccine>();
      return vaccineList;
    }
    return null;
  }

  static Future<void> saveDefaultUserData(UserCredential userCredential) async {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection("Users");
    QuerySnapshot userSnapshot = await usersRef.get();
    bool hasData = false;
    userSnapshot.docs.map((doc) {
      if (doc.id == userCredential.user!.uid) hasData = true;
    }).toList();
    if (hasData) return;

    final CollectionReference vaccinesRef =
        FirebaseFirestore.instance.collection("Vaccines");

    QuerySnapshot querySnapshot = await vaccinesRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.id).toList();
    print(allData);
    List<Map>? defaultVaccines = [];
    for (var i = 0; i < allData.length; i++) {
      defaultVaccines.add({"vaccineID": allData[i], "isVaccineted": false});
    }
    await usersRef.doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'displayName': userCredential.user!.displayName,
      'vaccines': defaultVaccines
    });
  }
}
