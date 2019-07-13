import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/user.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';
import 'package:ichat_pfe/widgets/editpassword.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';


class Profile extends StatefulWidget {
  final String id;

  const Profile({Key key, this.id}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;

  @override
  void initState() {
    FirebaseUtils().getUser(widget.id).then((onValue) {
      setState(() {
        user = onValue;
      });
      //  print(user.imgUrl);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      body: FutureBuilder(
        future: FirebaseUtils().getUser(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                GestureDetector(
                  onTap: () => _takePicture(ImageSource.gallery),
                  child: Center(
                    child: Container(
                        child: user.imgUrl == "url"
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text(user.initiales,
                                    style: TextStyle(
                                        color: Color(0xff4e54c8),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                5)),
                                radius: MediaQuery.of(context).size.width / 4,
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    CachedNetworkImageProvider(user.imgUrl),
                                radius: MediaQuery.of(context).size.width / 4,
                              )),
                  ),
                ),
                // Divider(
                //   color: Colors.white.withOpacity(.2),
                //   height: 1.5,
                // ),
                Center(
                  child: Container(
                    child: Text(
                      user.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 16),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    child: Text(
                      user.email,
                      style: TextStyle(
                          color: Colors.white.withOpacity(.5),
                          fontSize: MediaQuery.of(context).size.width / 22),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 16),
                ),
                Divider(
                  color: Colors.white.withOpacity(.2),
                  height: 1.5,
                ),
                Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(LineIcons.bell),
                      maxRadius: 28,
                      backgroundColor: Colors.indigo.withOpacity(.6),
                      foregroundColor: Colors.white,
                    ),
                    title: Text("Notifications",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 20)
                        // style: TextStyle(fontSize: 20, color: KColors.third),
                        ),
                    subtitle: Text("Active or away",
                        style: TextStyle(
                            color: Colors.white.withOpacity(.6),
                            fontSize: MediaQuery.of(context).size.width / 28)
                        // style: TextStyle(fontSize: 18, color: KColors.fourth)
                        ),
                    trailing: Switch(
                      value: FirebaseUtils.temp,
                      activeColor: Colors.greenAccent,
                      inactiveThumbColor: Colors.grey,
                      onChanged: (value) async {
                        if (value) {
                          FirebaseUtils.temp=value;
                          await FirebaseUtils()
                              .base_user
                              .child(widget.id)
                              .update({"isActive": "Active"});
                        } else {
                          FirebaseUtils.temp=value;
                          await FirebaseUtils()
                              .base_user
                              .child(widget.id)
                              .update({"isActive": ""});
                        }
                      },
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(.2),
                  height: 1.5,
                ),
                Container(
                  child: ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              new EditPassword());
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.greenAccent.withOpacity(.6),
                      foregroundColor: Colors.white,
                      radius: 28,
                      child: Icon(LineIcons.key),
                    ),
                    trailing: Icon(LineIcons.info_circle, color: Colors.white),
                    title: Text("Change Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 20)),
                    subtitle: Text("press to update password",
                        style: TextStyle(
                            color: Colors.white.withOpacity(.6),
                            fontSize: MediaQuery.of(context).size.width / 28)),
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(.2),
                  height: 1.5,
                ),
                Container(
                  child: ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "Delete account?",
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: () => Navigator.pop(context)),
                                  FlatButton(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () => FirebaseUtils()
                                              .deleteUser(widget.id)
                                              .then((onValue) {
                                            Navigator.pop(context);
                                          }).catchError((onError) {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    SimpleDialog(
                                                      title: Text(
                                                          "Somthig went wrong!"),
                                                      children: <Widget>[
                                                        Text(
                                                            "Could not delete account..")
                                                      ],
                                                    ));
                                          })),
                                ],
                              ));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.redAccent.withOpacity(.6),
                      foregroundColor: Colors.white,
                      radius: 28,
                      child: Icon(Icons.remove_circle_outline),
                    ),
                    trailing: Icon(LineIcons.info_circle, color: Colors.white),
                    title: Text("Delete Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 20)),
                    subtitle: Text("delete all your informations",
                        style: TextStyle(
                            color: Colors.white.withOpacity(.6),
                            fontSize: MediaQuery.of(context).size.width / 28)),
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(.2),
                  height: 1.5,
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                "Loading profile..",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _takePicture(ImageSource source) async {
    File image;
    image = await ImagePicker.pickImage(
        source: source, maxWidth: 500.0, maxHeight: 500.0);
    FirebaseUtils()
        .savePicture(image, FirebaseUtils().storage_users.child(widget.id))
        .then((string) async {
      await FirebaseUtils().base_user.child(user.id).update({"imgUrl": string});
      // Map map = user.toMap();
      // map["imgUrl"] = string;
      // FirebaseUtils().addUser(user.id, map);
      FirebaseUtils().getUser(widget.id).then((onValue) {
        setState(() {
          user = onValue;
        });
        //  print(user.imgUrl);
      });
    });
  }
}
