import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageTail extends StatefulWidget {
  final String initials, lastMsg, name, time, imgUrl;
  final GestureTapCallback onTap;

  const MessageTail({
    Key key,
    this.initials,
    this.lastMsg,
    this.name,
    this.time,
    this.onTap,
    this.imgUrl,
  }) : super(key: key);

  @override
  _MessageTailState createState() => _MessageTailState();
}

class _MessageTailState extends State<MessageTail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.imgUrl);
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.only(top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.04),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        // onLongPress: () {
        //   showDialog(
        //       context: context,
        //       builder: (context) => AlertDialog(
        //             title: Text(
        //               "Delete chat?",
        //             ),
        //             actions: <Widget>[
        //               FlatButton(
        //                   child: Text("Cancel"),
        //                   onPressed: () => Navigator.pop(context)),
        //               FlatButton(
        //                   child: Text(
        //                     "Delete",
        //                     style: TextStyle(color: Colors.red),
        //                   ),
        //                   onPressed: () => FirebaseUtils()
        //                           .deleteChat(widget.chatId,)
        //                           .then((onValue) {
        //                         Navigator.pop(context);
        //                       }).catchError((onError) {
        //                         showDialog(
        //                             context: context,
        //                             builder: (context) => SimpleDialog(
        //                                   title: Text("Somthig went wrong!"),
        //                                   children: <Widget>[
        //                                     Text("Could not delete chat..")
        //                                   ],
        //                                 ));
        //                       })),
        //             ],
        //           ));
        // },
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.4),
            borderRadius: BorderRadius.circular(18),
          ),
          child: widget.imgUrl == "url"
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xff4e54c8),
                  child: Text(widget.initials),
                  //  Text(user.initiales,
                  //     style: TextStyle(color: Color(0xff4e54c8))),
                  maxRadius: 28,
                )
              : CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    widget.imgUrl,
                  ),
                  maxRadius: 28,
                ),
        ),
        title: Text(widget.name,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 18)),
        subtitle: Text(widget.lastMsg,
            style: TextStyle(
                color: Colors.white.withOpacity(.6),
                fontSize: MediaQuery.of(context).size.width / 26)),
        trailing: Text(widget.time,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 24)),
        onTap: widget.onTap,
      ),
    );
  }
}
