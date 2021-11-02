import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ToDoVaccinesView extends StatefulWidget {
  ToDoVaccinesView({Key? key}) : super(key: key);

  @override
  _ToDoVaccinesViewState createState() => _ToDoVaccinesViewState();
}

class _ToDoVaccinesViewState extends State<ToDoVaccinesView> {
  late final User? user;
  @override
  initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;

    user = auth.currentUser;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yapilacak Asilar'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Text("Hosgeldiniz " + user!.displayName.toString()),
      ),
    );
  }
}
