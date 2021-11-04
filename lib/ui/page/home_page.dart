import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/core/local/simple_local_save.dart';
import 'package:tibbi_asi_takibi/ui/page/all_vaccines.dart';
import 'package:tibbi_asi_takibi/ui/page/todo_vaccines.dart';

import 'complated_vaccines.dart';

class HomePageView extends StatefulWidget {
  @override
  HomePageViewState createState() => HomePageViewState();
}

class HomePageViewState extends State<HomePageView> {
  int selectedIndex = 0;
  static DateTime? date;
  List<Widget> screens = [
    ToDoVaccinesView(),
    ComplatedVaccinesView(),
    AllVaccinesView(),
  ];
  @override
  void initState() {
    date = SimpleLocalSave.getDate() ?? null;
    super.initState();
  }

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
            label: 'Asi Bilgileri',
          ),
        ],
      ),
    );
  }
}
