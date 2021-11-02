import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/core/server/firebase_service.dart';
import 'package:tibbi_asi_takibi/model/vaccine.dart';

class AllVaccinesView extends StatefulWidget {
  AllVaccinesView({Key? key}) : super(key: key);

  @override
  _AllVaccinesViewState createState() => _AllVaccinesViewState();
}

class _AllVaccinesViewState extends State<AllVaccinesView> {
  late FirebaseServise service;
  @override
  void initState() {
    service = FirebaseServise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tum Asilar"),
      ),
      body: FutureBuilder(
        future: service.getVaccines(),
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
      itemBuilder: (context, index) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: true,
        onChanged: (valuee) => setState(
          () => {},
        ),
        title: Text(list[index].name.toString()),
        subtitle: Text(list[index].dayCount.toString() + "gun kaldi"),
      ),
      physics: BouncingScrollPhysics(),
      itemCount: list.length,
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text('Tum Asilar'),
  //       ),
  //       body: ListView.builder(
  //         padding: EdgeInsets.all(10),
  //         itemBuilder: (context, index) => CheckboxListTile(
  //           controlAffinity: ListTileControlAffinity.leading,
  //           value: HomePageState.allVaccines[index].isVaccinate,
  //           onChanged: (valuee) => setState(
  //               () => HomePageState.allVaccines[index].isVaccinate = valuee!),
  //           title: Text(HomePageState.allVaccines[index].vaccineName),
  //         ),
  //         physics: BouncingScrollPhysics(),
  //         itemCount: HomePageState.allVaccines.length,
  //       ));
  // }
}
