import 'package:flutter/material.dart';

class ToDoVaccinesView extends StatefulWidget {
  ToDoVaccinesView({Key? key}) : super(key: key);

  @override
  _ToDoVaccinesViewState createState() => _ToDoVaccinesViewState();
}

class _ToDoVaccinesViewState extends State<ToDoVaccinesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yapilacak Asilar'),
      ),
      body: Center(child: Text("to do")),
    );
  }
}
