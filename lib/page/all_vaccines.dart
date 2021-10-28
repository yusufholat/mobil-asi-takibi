import 'package:flutter/material.dart';

import 'home_page.dart';

class AllVaccinesView extends StatefulWidget {
  AllVaccinesView({Key? key}) : super(key: key);

  @override
  _AllVaccinesViewState createState() => _AllVaccinesViewState();
}

class _AllVaccinesViewState extends State<AllVaccinesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tum Asilar'),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) => CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: HomePageState.allVaccines[index].isVaccinate,
            onChanged: (valuee) => setState(
                () => HomePageState.allVaccines[index].isVaccinate = valuee!),
            title: Text(HomePageState.allVaccines[index].vaccineName),
          ),
          physics: BouncingScrollPhysics(),
          itemCount: HomePageState.allVaccines.length,
        ));
  }
}
