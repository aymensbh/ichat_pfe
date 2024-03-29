import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/user.dart';
import 'package:ichat_pfe/tabs/chatPage.dart';
import 'package:ichat_pfe/tabs/deff.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:ichat_pfe/widgets/userTail.dart';
import 'package:line_icons/line_icons.dart';

class Contacts extends StatefulWidget {
  final String id;

  const Contacts({Key key, this.id}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(LineIcons.edit),
          backgroundColor: Colors.white,
          foregroundColor: Color(0xff4e54c8),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Deff(
                          id: widget.id,
                        )));
          },
          elevation: 2,
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: FirebaseUtils().getUser(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
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
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => ChatPage(
                                    id: widget.id,
                                    partner: newUser,
                                  ))),
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
        ));
  }
}
