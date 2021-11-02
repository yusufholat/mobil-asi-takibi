import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tibbi_asi_takibi/model/vaccine.dart';

class FirebaseServise {
  static const String FIREBASE_URL =
      "https://asi-takip-uygulamasi-default-rtdb.firebaseio.com/";

  Future<List<Vaccine>> getVaccines() async {
    var url = Uri.parse("$FIREBASE_URL/vaccines.json");
    final response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final jsonModel = json.decode(response.body);
      final userList = jsonModel
          .map((e) => Vaccine.fromJson(e as Map<String, dynamic>))
          .toList()
          .cast<Vaccine>();
      print(userList);
      return userList;
    } else
      return Future.error(response.statusCode);
  }
}
