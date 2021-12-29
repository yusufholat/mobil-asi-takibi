import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/core/local/simple_local_save.dart';
import 'package:tibbi_asi_takibi/core/server/firebase_service.dart';
import 'package:tibbi_asi_takibi/core/server/google_signin.dart';
import 'package:tibbi_asi_takibi/model/user.dart';
import 'package:intl/intl.dart';
import 'package:tibbi_asi_takibi/ui/page/home_page.dart';
import 'package:tibbi_asi_takibi/ui/page/login_view.dart';

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
        title: Text('Yapılacak Aşılar'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              bool loggedOut = await GoogleSigninHelper.signOut();

              if (loggedOut) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                    (route) => false);
              }
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: service.getUserModelwithID(user!.uid),
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
            "Hoşgeldiniz " + _user.displayName.toString(),
            style: TextStyle(fontSize: 24),
          ),
          Divider(),
          Row(
            children: [
              Text("Doğum Tarihi Giriniz :  "),
              Expanded(child: Container()),
              OutlinedButton(
                  onPressed: () => pickDate(context), child: getDateText()),
            ],
          ),
          Divider(),
          Expanded(
            child: HomePageViewState.date == null
                ? Text(
                    "Çocuğunuzun yapılacak aşılarını görmek için doğum tarihini giriniz!")
                : ListView.builder(
                    itemBuilder: (context, index) =>
                        buildListTile(_user, index),
                    physics: BouncingScrollPhysics(),
                    itemCount: _user.vaccines.length,
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile(DbUser data, int index) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.all(5),
      title: Text(data.vaccines[index].vaccineName),
      subtitle: getRangeDate(data.vaccines[index].dayCount),
      value: data.vaccines[index].isVaccineted,
      onChanged: (bool? value) async {
        DateTime newDate = HomePageViewState.date!
            .add(Duration(days: data.vaccines[index].dayCount));

        int days = DateTime.now().difference(newDate).inDays;
        if (days >= 0) {
          await service.changeVaccineStatus(data, index);
          setState(() {});
        } else {
          final snackBar = SnackBar(
            content: Text('Aşının günü daha gelmedi!'),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              onPressed: () {},
              label: "Tamam",
            ),
          );
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
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
    else {
      await service.resetAllIsVaccineted();
      SimpleLocalSave.setDate(newDate);
      HomePageViewState.date = newDate;
    }
    setState(() {});
  }

  Text getDateText() {
    if (HomePageViewState.date == null)
      return Text("Doğum Tarihi Seçiniz");
    else
      return Text(
          '${HomePageViewState.date!.day}/${HomePageViewState.date!.month}/${HomePageViewState.date!.year}');
  }

  Text getRangeDate(int dayCount) {
    DateTime newDate = HomePageViewState.date!.add(Duration(days: dayCount));
    if (newDate.isBefore(DateTime.now())) {
      Duration range = DateTime.now().difference(newDate);
      return Text(range.inDays.toString() +
          "gün önceydi. (" +
          DateFormat("dd/MM/yyyy").format(newDate).toString() +
          ")");
    } else {
      Duration range = newDate.difference(DateTime.now());
      return Text(range.inDays.toString() +
          " gün kaldı.. (" +
          DateFormat("dd/MM/yyyy").format(newDate).toString() +
          ")");
    }
  }
}
