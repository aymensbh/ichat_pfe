import 'package:firebase_database/firebase_database.dart';

class User {
  String id;
  String name;
  String imgUrl;
  String initiales;
  String email;
  String isActive;

  User(DataSnapshot snapshot) {
    Map map = snapshot.value;
    name = map["name"];
    id = map["uid"];
    isActive=map["isActive"];
    email=map["email"];
    imgUrl = map["imgUrl"];
    if (name != null && name.length > 0) {
      initiales = name[0].toUpperCase()+name[1].toUpperCase();
    }
  }

  Map toMap() {
    return {"name": name, "imgUrl": imgUrl, "uid": id,"isActive":isActive,"email": email};
  }
}
