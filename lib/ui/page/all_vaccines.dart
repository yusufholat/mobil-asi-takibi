import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tibbi_asi_takibi/core/server/firebase_service.dart';
import 'package:tibbi_asi_takibi/model/vaccine.dart';

class AllVaccinesView extends StatefulWidget {
  AllVaccinesView({Key? key}) : super(key: key);

  @override
  _AllVaccinesViewState createState() => _AllVaccinesViewState();
}

class _AllVaccinesViewState extends State<AllVaccinesView> {
  late FirebaseServise service;
  late final User? user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    service = FirebaseServise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asi Bilgileri"),
      ),
      body: FutureBuilder(
        future: service.getAllVaccines(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData)
                return _listVaccines(snapshot.data as List<Vaccine>);
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

  Widget _listVaccines(List<Vaccine> list) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(list[index].name),
              content: Text(list[index].desc),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text('TAMAM'),
                ),
              ],
            ),
          );
        },
        title: Text(list[index].name.toString()),
        subtitle: Text("asi bilgileri icin tiklayiniz."),
        trailing: Icon(FontAwesomeIcons.questionCircle),
      ),
      physics: BouncingScrollPhysics(),
      itemCount: list.length,
    );
  }
}
