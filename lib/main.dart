import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ichat_pfe/screens/authPage.dart';
import 'package:ichat_pfe/screens/homePage.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // systemNavigationBarColor: Colors.transparent
    // systemNavigationBarDividerColor: Colors.transparent
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Router(),
    theme: ThemeData(
        accentColor: Color(0xff4e54c8),
        canvasColor: Color(0xff4e54c8),
        backgroundColor: Color(0xff4e54c8),
        textTheme: TextTheme(body1: TextStyle(fontFamily: 'baloo'))
        ),
  ));
}

class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData)
          return HomePage();
        else
          return AuthPage();
      },
    );
  }
}
