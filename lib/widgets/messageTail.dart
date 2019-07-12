import 'package:flutter/material.dart';

class MessageTail extends StatelessWidget {
  final String initials, lastMsg, name, time;
  final GestureTapCallback onTap;

  const MessageTail(
      {Key key, this.initials, this.lastMsg, this.name, this.time, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.only(top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.04),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(initials, style: TextStyle(color: Color(0xff4e54c8))),
          maxRadius: 28,
        ),
        title: Text(name,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 16)),
        subtitle: Text(lastMsg,
            style: TextStyle(
                color: Colors.white.withOpacity(.6),
                fontSize: MediaQuery.of(context).size.width / 24)),
        trailing:
            Text(time, style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width / 22)),
        onTap: onTap,
      ),
    );
  }
}
