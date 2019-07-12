import 'dart:io';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/message.dart';
import 'package:ichat_pfe/entities/user.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';
import 'package:ichat_pfe/widgets/messageLayout.dart';
import 'package:ichat_pfe/widgets/textzone.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

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
                  query: FirebaseUtils().base_message.child(FirebaseUtils()
                      .getMessageRef(widget.id, widget.partner.id)),
                  reverse: true,
                  sort: (a, b) => b.key.compareTo(a.key),
                  itemBuilder: (context, snapshot, animation, index) {
                    Message message = new Message(snapshot);
                    print(message.text);
                    return ChatBubble(myid: widget.id,partner: widget.partner,message: message,animation: animation,);
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
