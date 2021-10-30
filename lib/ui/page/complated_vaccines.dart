import 'package:flutter/material.dart';

import 'home_page.dart';

class ComplatedVaccinesView extends StatefulWidget {
  ComplatedVaccinesView({Key? key}) : super(key: key);

  @override
  _ComplatedVaccinesViewState createState() => _ComplatedVaccinesViewState();
}

class _ComplatedVaccinesViewState extends State<ComplatedVaccinesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yapilan Asilar'),
      ),
      body: Center(child: Text("to do")),
    );
  }
}
