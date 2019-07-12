import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ichat_pfe/entities/user.dart';

class FirebaseUtils {
  final firebaseAuth = FirebaseAuth.instance;
  static final base = FirebaseDatabase.instance.reference();
  final base_user = base.child("users");
  final base_message = base.child("messages");
  final base_chat = base.child("chats");

  Future<FirebaseUser> signIn(String mail, String password) async {
    final FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(
        email: mail, password: password);
    return user;
  }

  Future<String> myId() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    return user.uid;
  }

  Future<bool> logOut() async {
    await firebaseAuth.signOut().then((onValue) async{
    });
    return true;
  }

  Future<bool> changePassword(String password) async {
    await firebaseAuth.currentUser().then((user) {
      user.updatePassword(password);
    }).catchError((onError) {
      print(onError);
      return false;
    });
    return true;
  }

  sendMessage(User user, User moi, String text, String imageUrl) {
    String date = new DateTime.now().millisecondsSinceEpoch.toString();
    Map map = {
      "from": moi.id,
      "to": user.id,
      "text": text,
      "imageUrl": imageUrl,
      "dateString": date
    };
    base_message.child(getMessageRef(moi.id, user.id)).child(date).set(map);
    base_chat
        .child(moi.id)
        .child(user.id)
        .set(getChat(moi.id, user, text, date));
    base_chat
        .child(user.id)
        .child(moi.id)
        .set(getChat(moi.id, moi, text, date));
  }

  Map getChat(String sender, User user, String text, String dateString) {
    Map map = user.toMap();
    map["monId"] = sender;
    map["last_message"] = text;
    map["dateString"] = dateString;
    return map;
  }

  String getMessageRef(String from, String to) {
    String resultat = "";
    List<String> liste = [from, to];
    liste.sort((a, b) => a.compareTo(b));
    for (var x in liste) {
      resultat += x + "+";
    }
    return resultat;
  }

  Future<FirebaseUser> signup(
      String email, String password, String name) async {
    final FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    String uid = user.uid;
    Map<String, String> map = {
      "uid": uid,
      "name": name,
      "email": email,
      "isActive": "Active",
      "imgUrl": ""
    };
    addUser(uid, map);
    return user;
  }

  Future<User> getUser(String id) async {
    DataSnapshot snapshot = await base_user.child(id).once();
    return new User(snapshot);
  }

  addUser(String uid, Map map) {
    base_user.child(uid).set(map);
  }

  //Storage
  static final base_storage = FirebaseStorage.instance.ref();
  final StorageReference storage_users = base_storage.child("users");
  final StorageReference storage_messages = base_storage.child("messages");

  Future<String> savePicture(
      File file, StorageReference storageReference) async {
    StorageUploadTask storageUploadTask = storageReference.putFile(file);
    StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
