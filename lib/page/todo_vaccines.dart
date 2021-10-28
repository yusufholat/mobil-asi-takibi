import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/model/vaccine.dart';
import 'package:tibbi_asi_takibi/page/home_page.dart';

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
        body: HomePageState.allVaccines
                .every((element) => element.isVaccinate == true)
            ? Center(
                child: Text("Yapilacak Asiniz Bulunmamaktadir."),
              )
            : ListView(
                padding: EdgeInsets.all(10),
                physics: BouncingScrollPhysics(),
                children: getNotVaccinetedItems(HomePageState.allVaccines),
              ));
  }

  getNotVaccinetedItems(List<Vaccine> allVaccines) {
    List<Widget> widget = [];
    allVaccines.forEach((element) {
      if (element.isVaccinate == false)
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
