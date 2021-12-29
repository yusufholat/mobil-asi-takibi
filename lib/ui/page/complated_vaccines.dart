import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/core/server/firebase_service.dart';
import 'package:tibbi_asi_takibi/model/user.dart';

class ComplatedVaccinesView extends StatefulWidget {
  ComplatedVaccinesView({Key? key}) : super(key: key);

  @override
  _ComplatedVaccinesViewState createState() => _ComplatedVaccinesViewState();
}

class _ComplatedVaccinesViewState extends State<ComplatedVaccinesView> {
  late final User? user;
  late FirebaseServise service;

  @override
  initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    service = FirebaseServise();
    user = auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yapılan Aşılar'),
      ),
      body: FutureBuilder(
        future: service.getUserComplatedVaccines(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData)
                return _listVaccines(snapshot.data as List<Vaccines>);
              else
                return Center(
                  child: Text("data not found"),
                );
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _listVaccines(List<Vaccines> data) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemBuilder: (context, index) => buildListTile(data, index),
        physics: BouncingScrollPhysics(),
        itemCount: data.length,
      ),
    );
  }

  Widget buildListTile(List<Vaccines> data, int index) {
    return ListTile(
      contentPadding: EdgeInsets.all(5),
      title: Text(data[index].vaccineName),
      trailing: Icon(Icons.check_circle_outline_rounded),
    );
  }
}
