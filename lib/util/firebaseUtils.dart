import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseUtils {
  final firebaseAuth = FirebaseAuth.instance;
  static final base = FirebaseDatabase.instance.reference();
  final base_user = base.child("users");
  final base_chat=base.child("chats");

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
    await firebaseAuth.signOut();
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

  Future<FirebaseUser> signup(String email, String password, String name) async {
    final FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    String uid = user.uid;
    Map<String, String> map = {
      "uid": uid,
      "name": name,
      "email": email,
      "isActive": "active",
      "imgUrl": "url"
    };
    addUser(uid, map);
    return user;
  }

  addUser(String uid, Map map) {
    base_user.child(uid).set(map);
  }
}
