import 'package:flutter/material.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';


class EditPassword extends StatefulWidget {
  @override
  EditPasswordState createState() {
    return EditPasswordState();
  }
}

class EditPasswordState extends State<EditPassword> {
  final formKey = GlobalKey<FormState>();
  String _password;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: KColors.secondary,
      title: Text(
        "Reset password",
        // style: TextStyle(color: KColors.third),
      ),
      content: Container(
        padding: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: TextFormField(
            onSaved: (input) {
              _password = input;
            },
            validator: (input) {
              if (input.length < 6) {
                return "provide more than 6 characters";
              }
            },
            cursorWidth: 1,
            // cursorColor: KColors.fourth,
            style: TextStyle(
                // color: KColors.third,
                ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              // fillColor: KColors.primary,
              filled: true,
              hintText: 'Aa',
              hintStyle: TextStyle(
                  // color: KColors.fourth,
                  ),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(50),
              //   borderSide: BorderSide(color: KColors.secondary),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(50),
              //   borderSide: BorderSide(color: KColors.secondary),
              // ),
              // errorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(50),
              //   borderSide: BorderSide(color: KColors.lightPopout),
              // ),
              // focusedErrorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(50),
              //   borderSide: BorderSide(color: KColors.secondary),
              // ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            // style: TextStyle(color: KColors.fourth),
          ),
        ),
        FlatButton(
          onPressed: edit,
          child: Text(
            "Reset",
            style: TextStyle(color: Colors.green),
          ),
        )
      ],
    );
  }

  Future<void> edit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      FirebaseUtils().updatePassword(_password);
      Navigator.pop(context);
    }
  }
}
