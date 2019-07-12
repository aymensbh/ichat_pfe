import 'dart:io';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/message.dart';
import 'package:ichat_pfe/entities/user.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';
import 'package:ichat_pfe/widgets/messageLayout.dart';
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
                height: 1.5,
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

class TextZone extends StatefulWidget {
  final User partner;
  final String id;

  const TextZone({Key key, this.partner, this.id}) : super(key: key);

  @override
  _TextZoneState createState() => _TextZoneState();
}

class _TextZoneState extends State<TextZone> {
  TextEditingController _textEditingController;
  User me;

  @override
  void initState() {
    _textEditingController = new TextEditingController();

    FirebaseUtils().getUser(widget.id).then((user) {
      setState(() {
        me = user;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: IconButton(
              icon: Icon(
                LineIcons.photo,
                color: Color(0xff4e54c8)
              ),
              onPressed: () {
                takePicture(ImageSource.gallery);
              },
            ),
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: _textEditingController,
                cursorWidth: 1,
                cursorColor: Colors.grey,
                style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                    // fontFamily: 'product'
                    ),
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.all(
                        10), //--------------------------------------------
                    hintText: 'Aa',
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(.5),
                      // fontFamily: 'product'
                    ),
                    fillColor: Color.fromRGBO(240, 252, 252, 1),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff4e54c8),
                         width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff4e54c8),
                         width: 1),
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: Color(0xff4e54c8),
              ),
              onPressed: _sendButtonPressed(),
            ),
          )
        ],
      ),
    );
  }

  _sendButtonPressed() {
    if (_textEditingController.text != null &&
        _textEditingController.text != "") {
      String text = _textEditingController.text;
      FirebaseUtils().sendMessage(widget.partner, me, text, null);
      _textEditingController.clear();
      FocusScope.of(context).requestFocus(new FocusNode());
    } else {
      print("Texte vide ou null");
    }
  }

  Future<void> takePicture(ImageSource source) async {
    File file = await ImagePicker.pickImage(
        source: source, maxWidth: 1000.0, maxHeight: 1000.0);
    String date = new DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseUtils()
        .savePicture(
            file, FirebaseUtils().storage_messages.child(widget.id).child(date))
        .then((string) {
      FirebaseUtils().sendMessage(widget.partner, me, null, string);
    });
  }
}
