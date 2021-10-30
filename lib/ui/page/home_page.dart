import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/page/all_vaccines.dart';
import 'package:tibbi_asi_takibi/page/complated_vaccines.dart';
import 'package:tibbi_asi_takibi/page/todo_vaccines.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool valuee = false;
  List<Widget> screens = [
    ToDoVaccinesView(),
    ComplatedVaccinesView(),
    AllVaccinesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white60,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Yapilacak Asilar',
            backgroundColor: Theme.of(context).accentColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Yapilan Asilar',
            backgroundColor: Theme.of(context).accentColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_rounded),
            label: 'Tum Asilar',
            backgroundColor: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
