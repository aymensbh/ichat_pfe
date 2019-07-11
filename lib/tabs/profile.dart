import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String id;

  const Profile({Key key, this.id}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff1CD8D2),
    );
  }
}
