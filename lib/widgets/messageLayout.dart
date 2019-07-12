import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/message.dart';
import 'package:ichat_pfe/entities/user.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final User partner;
  final String myid;
  final Animation animation;

  const ChatBubble(
      {Key key, this.message, this.partner, this.myid, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(parent: animation, curve: Curves.easeIn),
      child: new Container(
        margin: EdgeInsets.all(10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: widgetsBubble(message.from == myid, context),
        ),
      ),
    );
  }

  List<Widget> widgetsBubble(bool me, BuildContext context) {
    CrossAxisAlignment alignement =
        (me) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Color bubbleColor = (me) ? Color(0xff1CD8D2) : Colors.grey.withOpacity(.2);
    Color textColor = (me) ? Colors.white : Colors.black.withOpacity(.7);
    EdgeInsets cardMargin = (me)
        ? EdgeInsets.only(left: MediaQuery.of(context).size.width / 3)
        : EdgeInsets.only(right: MediaQuery.of(context).size.width / 3);

    return <Widget>[
      me
          ? Padding(padding: EdgeInsets.all(8.0))
          : Image.network(
              partner.imgUrl,
            ),
      Expanded(
          child: Column(
        crossAxisAlignment: alignement,
        children: <Widget>[
          Container(
              child: Text(
            message.dateString,
            style: TextStyle(color: Colors.grey),
          )),
          Card(
            margin: cardMargin,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: bubbleColor,
            child: Container(
                padding: EdgeInsets.all(10.0),
                child: (message.imageUrl == null)
                    ? Text(
                        message.text ?? "",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15.0,
                        ),
                      )
                    : Image.network(
                        message.imageUrl,
                      )),
          )
        ],
      ))
    ];
  }
}
