import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/user.dart';


class UserTail extends StatelessWidget {
  final User user;

  const UserTail({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.only(top:6,bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.2),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                  
                ),
                child: ListTile(
                  leading: user.imgUrl.isEmpty?CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(user.initiales,style: TextStyle(color: Color(0xff1CD8D2))),
                    maxRadius: 28,
                  ):
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(user.imgUrl,),
                    maxRadius: 28,
                  ),
                  title: Text(user.name,style: TextStyle(color: Colors.white,fontSize: 22)),
                  subtitle: Text(user.email,style: TextStyle(color: Colors.white.withOpacity(.8),fontSize: 18)),
                  trailing: Text(user.isActive,style: TextStyle(color: Colors.white,fontSize: 18)),
                ),
              );
  }
}