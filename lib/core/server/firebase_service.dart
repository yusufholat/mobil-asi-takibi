import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tibbi_asi_takibi/model/user.dart';

import 'package:tibbi_asi_takibi/model/vaccine.dart';

class FirebaseServise {
  // static const String FIREBASE_URL =
  //     "https://asi-takip-uygulamasi-default-rtdb.firebaseio.com/";

  Future<List<Vaccine>?> getAllVaccines() async {
    // var url = Uri.parse("$FIREBASE_URL/vaccines.json");
    // final response = await http.get(url);
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

  Future<DbUser> getUserToDoVaccines(User user) async {
    final CollectionReference vaccinesRef =
        FirebaseFirestore.instance.collection("Vaccines");

    // QuerySnapshot vacccinesQuerySnapshot = await vaccinesRef.get();
    var data = await getUserData(user.uid);

    String jsonData = json.encode(data);
    var jsonn = json.decode(jsonData);
    DbUser userr = DbUser.fromJson(jsonn);
    return userr;
    // List todoVaccineIDList = [];
    // List<Vaccine> todoVaccines = [];
    // userr.vaccines.forEach((element) {
    //   if (element.isVaccineted == false) {
    //     todoVaccineIDList.add(element.vaccineID);
    //   }
    // });
    // vacccinesQuerySnapshot.docs.forEach((doc) {
    //   if (todoVaccineIDList.contains(doc.id)) {
    //     todoVaccines.add(Vaccine.fromJson(doc.data() as Map<String, dynamic>));
    //   }
    // });
    // todoVaccines.sort((a, b) => a.dayCount.compareTo(b.dayCount));
    // return todoVaccines;
  }

  Future<Vaccine> getVaccineWithDocID(String vaccineDocID) async {
    final data = (await FirebaseFirestore.instance
            .collection("Vaccines")
            .doc(vaccineDocID)
            .get())
        .data();
    String jsonData = json.encode(data);
    var jsonn = json.decode(jsonData);
    Vaccine vacc = Vaccine.fromJson(jsonn);
    return vacc;
  }

  Future<Map<String, dynamic>?> getUserData(String documentID) async {
    final _data = (await FirebaseFirestore.instance
            .collection('Users')
            .doc(documentID)
            .get())
        .data();
    return _data;
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
