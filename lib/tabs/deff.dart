import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/user.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';
import 'package:ichat_pfe/widgets/userTail.dart';

class Deff extends StatefulWidget {
  final String id;

  const Deff({Key key, this.id}) : super(key: key);

  @override
  _DeffState createState() => _DeffState();
}

class _DeffState extends State<Deff> {
  TextEditingController controller;

  @override
  void initState() {
    controller = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff4e54c8), Color(0xff8f94fb)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              hintText: 'type a message..',
              hintStyle: TextStyle(color: Colors.white.withOpacity(.4)),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.white.withOpacity(.8), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.white.withOpacity(.8), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        body: Container(
            color: Colors.transparent,
            child: FutureBuilder(
              future: FirebaseUtils().getUser(widget.id),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.done) {
                  return FirebaseAnimatedList(
                    query: FirebaseUtils().base_user,
                    sort: (a, b) => a.value["name"].compareTo(b.value["name"]),
                    itemBuilder: (context, snapshot, animation, index) {
                      User newUser = new User(snapshot);
                      if (newUser.id == widget.id)
                        return Container();
                      else {
                        print(newUser.imgUrl);
                        return UserTail(
                          user: newUser,
                          onTap: () {
                            if (controller.text.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        contentPadding: EdgeInsets.all(8),
                                        title: Text("Text is Empty!"),
                                        children: <Widget>[
                                          Text('please type something')
                                        ],
                                      ));
                            } else {
                              FirebaseUtils().sendMessage(newUser,
                                  snapshot1.data, controller.text.trim(), null);
                            }
                          },
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      "Loading contacts..",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }
              },
            )),
      ),
    );
  }
}
