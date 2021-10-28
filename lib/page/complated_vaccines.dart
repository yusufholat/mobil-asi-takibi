import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/model/vaccine.dart';

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
        body: ListView(
          padding: EdgeInsets.all(10),
          physics: BouncingScrollPhysics(),
          children: getVaccinetedItems(HomePageState.allVaccines),
        ));
  }

  List<Widget> getVaccinetedItems(List<Vaccine> objects) {
    List<Widget> widget = [];
    objects.forEach((element) {
      if (element.isVaccinate == true)
        widget.add(
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: element.isVaccinate,
            onChanged: (valuee) =>
                setState(() => element.isVaccinate = valuee!),
            title: Text(element.vaccineName),
          ),
        );
    });
    return widget;
  }
}
