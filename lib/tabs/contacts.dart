import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/user.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:ichat_pfe/widgets/userTail.dart';

class Contacts extends StatefulWidget {
  final String id;

  const Contacts({Key key, this.id}) : super(key: key);


  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff1CD8D2),
        child: FirebaseAnimatedList(
          query: FirebaseUtils().base_user,
          sort: (a, b) => a.value["name"].compareTo(b.value["name"]),
          itemBuilder: (context,snapshot,animation,index){
            User newUser = new User(snapshot);
            if(newUser.id==widget.id)
              return Container();
            else{
              print(newUser.imgUrl);
              return UserTail(user: newUser,);
            }
          },
        ));
  }
}

