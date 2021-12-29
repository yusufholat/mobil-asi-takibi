import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/core/server/google_signin.dart';
import 'package:tibbi_asi_takibi/ui/page/home_page.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViState createState() => _LoginViState();
}

class _LoginViState extends State<LoginView> {
  late GoogleSigninHelper googleSigninHelper;
  @override
  void initState() {
    googleSigninHelper = GoogleSigninHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lütfen Giriş Yapınız"),
      ),
      body: Center(
        child: FloatingActionButton.extended(
          label: Text("Giriş Yap"),
          icon: Icon(Icons.login),
          onPressed: () async {
            bool loggedIn = await googleSigninHelper.signIn();
            if (loggedIn) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageView()),
                  (route) => false);
            }
          },
        ),
      ),
    );
  }
}
