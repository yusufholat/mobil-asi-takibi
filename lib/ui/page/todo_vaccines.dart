import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/core/server/firebase_service.dart';
import 'package:tibbi_asi_takibi/model/user.dart';
import 'package:tibbi_asi_takibi/model/vaccine.dart';
import 'package:intl/intl.dart';
import 'package:tibbi_asi_takibi/ui/page/home_page.dart';

class ToDoVaccinesView extends StatefulWidget {
  ToDoVaccinesView({Key? key}) : super(key: key);

  @override
  _ToDoVaccinesViewState createState() => _ToDoVaccinesViewState();
}

class _ToDoVaccinesViewState extends State<ToDoVaccinesView> {
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
        title: Text('Yapilacak Asilar'),
      ),
      body: FutureBuilder(
        future: service.getUserToDoVaccines(user!),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData)
                return _listVaccines(snapshot.data as DbUser);
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

  Widget _listVaccines(DbUser _user) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            "Hosgeldiniz " + _user.displayName.toString(),
            style: TextStyle(fontSize: 24),
          ),
          Divider(),
          Row(
            children: [
              Text("Dogum Tarihi Giriniz :  "),
              Expanded(child: Container()),
              OutlinedButton(
                  onPressed: () => pickDate(context), child: getText()),
            ],
          ),
          Divider(),
          Expanded(
            child: HomePageViewState.date == null
                ? Text(
                    "Cocugunuzun yapilacak asilarini gormek icin dogum tarihini giriniz!")
                : ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      contentPadding: EdgeInsets.all(5),
                      onTap: () {
                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return Center(
                        //         child: Text(list[index].name),
                        //       );
                        //     });
                      },
                      title: Text("dd"),
                      //subtitle: getRangeDate(list[index].dayCount),
                      trailing: IconButton(
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () {},
                          icon: Icon(Icons.check)),
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount: _user.vaccines.length,
                  ),
          ),
        ],
      ),
    );
  }

  void getVaccineName(DbUser _user, int index, String firstText) {
    late String text = service
        .getVaccineWithDocID(_user.vaccines[index].vaccineID)
        .then((value) => value.name)
        .toString();
    firstText = text;
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: HomePageViewState.date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );
    if (newDate == null)
      return;
    else
      setState(() {
        HomePageViewState.date = newDate;
      });
  }

  Text getText() {
    if (HomePageViewState.date == null)
      return Text("Dogum Tarihi Seciniz");
    else
      return Text(
          '${HomePageViewState.date!.day}/${HomePageViewState.date!.month}/${HomePageViewState.date!.year}');
  }

  Text getRangeDate(int dayCount) {
    DateTime newDate = HomePageViewState.date!.add(Duration(days: dayCount));
    if (newDate.isBefore(DateTime.now())) {
      Duration range = DateTime.now().difference(newDate);
      return Text(range.inDays.toString() +
          "gun onceydi.. (" +
          DateFormat("dd/MM/yyyy").format(newDate).toString() +
          ")");
    } else {
      Duration range = newDate.difference(DateTime.now());
      return Text(range.inDays.toString() + " gun kaldi");
    }
  }
}
