import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tibbi_asi_takibi/model/user.dart';

import 'package:tibbi_asi_takibi/model/vaccine.dart';

class FirebaseServise {
  Future<List<Vaccine>?> getAllVaccines() async {
    final CollectionReference vaccinesRef =
        FirebaseFirestore.instance.collection("Vaccines");

    QuerySnapshot querySnapshot =
        await vaccinesRef.orderBy("dayCount", descending: false).get();
    if (querySnapshot.docs.isNotEmpty) {
      final vaccineList = querySnapshot.docs
          .map((doc) => Vaccine.fromJson(doc.data() as Map<String, dynamic>))
          .toList()
          .cast<Vaccine>();
      return vaccineList;
    }
    return null;
  }

  Future<DbUser> getUserModelwithID(String userId) async {
    var data =
        (await FirebaseFirestore.instance.collection('Users').doc(userId).get())
            .data();

    String jsonData = json.encode(data);
    var jsonn = json.decode(jsonData);
    print(jsonn);
    DbUser userr = DbUser.fromJson(jsonn);
    return userr;
  }

  Future changeVaccineStatus(DbUser user, int index) async {
    String uidd = FirebaseAuth.instance.currentUser!.uid;
    List<Map>? defaultVaccines = [];
    DocumentReference ref =
        FirebaseFirestore.instance.collection('Users').doc(user.uid);

    DbUser us = await getUserModelwithID(uidd);
    var list = us.vaccines.toList();
    for (var i = 0; i < list.length; i++) {
      bool? value = us.vaccines[i].isVaccineted;
      if (i == index) value = !us.vaccines[i].isVaccineted!;
      defaultVaccines.add({
        "isVaccineted": value,
        "vaccineName": us.vaccines[i].vaccineName,
        "dayCount": us.vaccines[i].dayCount
      });
    }

    ref.update({"vaccines": defaultVaccines});
  }

  Future<List<Vaccines>> getUserComplatedVaccines() async {
    String uidd = FirebaseAuth.instance.currentUser!.uid;
    DbUser user = await getUserModelwithID(uidd);
    List<Vaccines> vaccines = [];
    user.vaccines.forEach((element) {
      if (element.isVaccineted == true) vaccines.add(element);
    });
    return vaccines;
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

    QuerySnapshot vaccineQuerySnapshot =
        await vaccinesRef.orderBy("dayCount", descending: false).get();
    final vaccinesData = vaccineQuerySnapshot.docs
        .map((doc) => doc.data())
        .cast<Map<String, dynamic>>()
        .toList();
    print(vaccinesData);
    List<Map>? defaultVaccines = [];
    for (var i = 0; i < vaccinesData.length; i++) {
      defaultVaccines.add({
        "isVaccineted": false,
        "vaccineName": vaccinesData[i]["name"],
        "dayCount": vaccinesData[i]["dayCount"]
      });
    }
    await usersRef.doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'displayName': userCredential.user!.displayName,
      'vaccines': defaultVaccines
    });
  }
}
