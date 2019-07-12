import 'package:flutter/material.dart';
import 'package:ichat_pfe/pages/login.dart';
import 'package:ichat_pfe/pages/signup.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  PageController _controller;

  @override
  void initState() {
    _controller = new PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [ Color(0xff93EDC7),Color(0xff1CD8D2),],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 8, left: 40, right: 40),
          // color: Color(0xFF383645),
          padding: MediaQuery.of(context).padding,
          child: Column(
            //work with design later
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welcome back to iChat!",
                        style: TextStyle(
                            fontSize: 46,
                            color: Colors.white,
                            fontFamily: "Baloo"),
                      ),
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.white,
                              onTap: () {
                                login(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 16,
                                child: Text("Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Baloo",fontSize: 20)),
                              )),
                        )),
                    Container(
                        margin: EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.white,
                              onTap: () {
                                signup(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 16,
                                child: Text("Signup",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Baloo",fontSize: 20)),
                              )),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    //  Scaffold(
    //   body: Container(
    //       decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //             colors: [Color(0xff1CD8D2), Color(0xff93EDC7)],
    //             begin: Alignment.topLeft,
    //             end: Alignment.bottomRight),
    //       ),
    //       child: PageView(
    //         // physics: NeverScrollableScrollPhysics(),
    //         controller: _controller,
    //         children: <Widget>[Login(), Login()],
    //       )),
    // );
  }
}
