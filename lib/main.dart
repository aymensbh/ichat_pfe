import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ichat_pfe/screens/authPage.dart';
import 'package:ichat_pfe/screens/homePage.dart';


void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Router(),
    theme: ThemeData(accentColor: Colors.blueAccent),
  ));
}


class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData)
          return HomePage();
        else
          return AuthPage();  
      },
      
    );
  }
}


