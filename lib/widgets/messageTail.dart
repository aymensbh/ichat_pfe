import 'package:flutter/material.dart';


class MessageTail extends StatelessWidget {

  final String initials,lastMsg,name,time;
  final GestureTapCallback onTap;

  const MessageTail({Key key, this.initials, this.lastMsg, this.name, this.time, this.onTap}) : super(key: key);

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
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(initials,style: TextStyle(color: Color(0xff1CD8D2))),
                    maxRadius: 28,
                  ),
                  title: Text(name,style: TextStyle(color: Colors.white,fontSize: 22)),
                  subtitle: Text(lastMsg,style: TextStyle(color: Colors.white.withOpacity(.8),fontSize: 18)),
                  trailing: Text(time,style: TextStyle(color: Colors.white,fontSize: 18)),
                  onTap: onTap,
                ),
              );
  }
}