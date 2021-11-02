import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/ui/page/all_vaccines.dart';
import 'package:tibbi_asi_takibi/ui/page/login_view.dart';
import 'package:tibbi_asi_takibi/ui/page/todo_vaccines.dart';

import 'complated_vaccines.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool valuee = false;
  List<Widget> screens = [
    LoginView(),
    ComplatedVaccinesView(),
    AllVaccinesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Yapilan Asilar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_rounded),
            label: 'Tum Asilar',
          ),
        ],
      ),
    );
  }
}
