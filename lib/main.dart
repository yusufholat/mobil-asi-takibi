import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/ui/page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobil Asi Takibi',
      theme:
          ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Comfortaa'),
      home: HomePage(),
    );
  }
}
