import 'package:flutter/material.dart';
import 'package:tibbi_asi_takibi/core/server/google_signin.dart';

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
        title: Text("Giris Yapman Lazim"),
      ),
      body: Center(
        child: FloatingActionButton.extended(
          label: Text("Google Login"),
          icon: Icon(Icons.login),
          onPressed: () async {
            await googleSigninHelper.signIn();
          },
        ),
      ),
    );
  }
}
