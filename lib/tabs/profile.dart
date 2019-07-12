import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/user.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';
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
    return Container(
      color: Colors.transparent,
      child: FutureBuilder(
        future: FirebaseUtils().getUser(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    child: user.imgUrl == ""
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(user.initiales,
                                style: TextStyle(color: Color(0xff4e54c8))),
                            radius: MediaQuery.of(context).size.width/4,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(user.imgUrl),
                            radius: MediaQuery.of(context).size.width/4,
                          )),
                          Divider(color: Colors.white.withOpacity(.2),height: 1.5,),
                          Container(
                            child: Text(user.name,style: TextStyle(color: Colors.white,fontSize: 30),),
                          ),
                          Container(
                            child: Text(user.email,style: TextStyle(color: Colors.white.withOpacity(.5),fontSize: 18),),
                          ),
                          Divider(color: Colors.white.withOpacity(.2),height: 1.5,),
                          Container(
                            child: ListTile(
                              onTap: (){},
                              leading: CircleAvatar(
                                backgroundColor: Colors.greenAccent,
                                foregroundColor: Colors.white,
                                radius: 28,
                                child: Icon(LineIcons.key),
                              ),
                              trailing: Icon(LineIcons.info_circle,color:Colors.white),
                              title: Text("Change Password",style: TextStyle(color: Colors.white,fontSize: 18)),
                              subtitle: Text("press to update password",style: TextStyle(color: Colors.white,fontSize: 12)),
                            ),
                          ),
                          Divider(color: Colors.white.withOpacity(.2),height: 1.5,),
                          Container(
                            child: ListTile(
                              onTap: (){},
                              leading: CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                radius: 28,
                                child: Icon(LineIcons.key),
                              ),
                              trailing: Icon(LineIcons.info_circle,color:Colors.white),
                              title: Text("Delete Account",style: TextStyle(color: Colors.white,fontSize: 18)),
                              subtitle: Text("delete all your informations",style: TextStyle(color: Colors.white,fontSize: 12)),
                            ),
                          ),
                          Divider(color: Colors.white.withOpacity(.2),height: 1.5,),
              ],
            );
          } else {
            return Center(
              child: Text("Loading..",style: TextStyle(color: Colors.white,fontSize: 18),),
            );
          }
        },
      ),
    );
  }
}
