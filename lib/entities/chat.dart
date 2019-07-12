import 'package:firebase_database/firebase_database.dart';
import 'package:ichat_pfe/entities/user.dart';
import 'package:ichat_pfe/util/timeUtiles.dart';

class Chat {
  String id;
  String last_message;
  String date;
  User user;

  Chat(DataSnapshot snapshot) {
    this.id = snapshot.value["monId"];
    String stringDate = snapshot.value["dateString"];
    this.date = DateHelper().getDate(stringDate);
    this.last_message = snapshot.value["last_message"];
    user = new User(snapshot);
  }
}
