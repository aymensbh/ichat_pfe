import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/message.dart';
import 'package:ichat_pfe/entities/user.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';
import 'package:ichat_pfe/widgets/messageLayout.dart';
import 'package:ichat_pfe/widgets/textzone.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final User partner;

  const ChatPage({Key key, this.id, this.partner}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.white),
            onPressed: () async {
                FirebaseUtils().deleteChat(widget.id, widget.partner.id);
                Navigator.pop(context);
            },
          )
        ],
        elevation: 2,
        backgroundColor: Color(0xff4e54c8),
        title: Text(widget.partner.name),
      ),
      body: Container(
        color: Colors.white,
        child: InkWell(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Column(
            children: <Widget>[
              Flexible(
                child: FirebaseAnimatedList(
                  query: FirebaseUtils()
                      .base_message
                      .child(FirebaseUtils()
                          .getMessageRef(widget.id, widget.partner.id))
                      .limitToLast(40),
                  reverse: true,
                  sort: (a, b) => b.key.compareTo(a.key),
                  itemBuilder: (context, snapshot, animation, index) {
                    Message message = new Message(snapshot);
                    print("from" + snapshot.value["dateString"]);
                    return GestureDetector(
                      child: ChatBubble(
                        myid: widget.id,
                        partner: widget.partner,
                        message: message,
                        animation: animation,
                      ),
                      onLongPress: () {
                        // showDialog(
                        //     context: context,
                        //     builder: (context) => AlertDialog(
                        //           title: Text("Delete message!"),
                        //           content: Text("delete this message"),
                        //           actions: <Widget>[
                        //             FlatButton(
                        //               child: Text("Cancel"),
                        //               onPressed: () => Navigator.pop(context),
                        //             ),
                        //             FlatButton(
                        //                 child: Text("Delete",style: TextStyle(color: Colors.red),),
                        //                 onPressed: () async {
                        //                  await FirebaseUtils()
                        //                       .base_message
                        //                       .child(FirebaseUtils()
                        //                           .getMessageRef(widget.id,
                        //                               widget.partner.id))
                        //                       .child(snapshot.value["dateString"]).reference().remove().then((onValue){
                        //                         print("deleted");
                        //                         Navigator.pop(context);
                        //                       }).catchError((onError){
                        //                         print("not deleted");
                        //                         Navigator.pop(context);
                        //                       });
                        //                 }),
                        //           ],
                        //         ));
                      },
                    );
                  },
                ),
              ),
              new Divider(
                height: 2,
                color: Color(0xff4e54c8).withOpacity(.2),
              ),
              new TextZone(
                partner: widget.partner,
                id: widget.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
