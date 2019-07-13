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
  static bool temp = true;

  Future<FirebaseUser> signIn(String mail, String password) async {
    final FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(
        email: mail, password: password);
    return user;
  }

  Future<bool> updatePassword(String password) async {
    await firebaseAuth.currentUser().then((user) {
      user.updatePassword(password).then((onValue) {
        logOut();
        return true;
      }).catchError((onError) {
        return false;
      });
    }).catchError((onError) {
      return false;
    });
    return true;
  }

  Future<String> myId() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    return user.uid;
  }

  Future<bool> logOut() async {
    await firebaseAuth.signOut().then((onValue) async {});
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
    map["id"] = sender;
    map["last_message"] = text;
    map["dateString"] = dateString;
    return map;
  }

  Future<void> deleteMsg() {
    //TODO: delete msg
  }

  String getMessageRef(String from, String to) {
    String resultat = "";
    List<String> liste = [from, to];
    liste.sort((a, b) => a.compareTo(b)); //TODO: huh??
    for (var x in liste) {
      resultat += x + "+";
    }
    return resultat;
  }

  Future<void> deffMsg(List<User> id, me, text, imageUrl) async {
    //TODO: Deffuse message!
    id.forEach((user) async {
      await sendMessage(user, me, text, imageUrl);
    });
  }

  // Future<void> deleteChat(String chatId) async {
  //   await base_chat.child(chatId).remove().then((onValue) {
  //     print("chat deleted");
  //   }).catchError((onError) {
  //     print("chat not deleted");
  //   });
  // }

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
      "imgUrl": "url"
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

  Future<void> deleteChat(String myId, String pId) async {
    await FirebaseUtils()
        .base_message
        .child(FirebaseUtils().getMessageRef(myId, pId))
        .remove()
        .then((onValue) async {
      await FirebaseUtils()
          .base_chat
          .child(myId)
          .child(pId)
          .remove()
          .then((onValue) async {
        await FirebaseUtils().base_chat.child(pId).child(myId).remove();
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<bool> deleteUser(String uid) async {
    await firebaseAuth.currentUser().then((user) async {
      await user.delete();
      await base_user.child(uid).remove().then((onValue) async {
        return true;
      }).catchError((onError) {
        return false;
      });
    }).catchError((onError) {
      return false;
    });
    return true;
  }

  //Storage
  static final base_storage = FirebaseStorage.instance.ref();
  final StorageReference storage_users = base_storage.child("users");
  final StorageReference storage_messages = base_storage.child("messages");

  Future<String> savePicture(
      File file, StorageReference storageReference) async {
    StorageUploadTask storageUploadTask = storageReference.putFile(file);
    StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
    // String url = await snapshot.ref.getDownloadURL();
    print(snapshot.ref.getDownloadURL());
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
