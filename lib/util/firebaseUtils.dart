import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseUtils {
  final firebaseAuth = FirebaseAuth.instance;
  static final base = FirebaseDatabase.instance.reference();
  final base_user = base.child("users");

  Future<FirebaseUser> signIn(String mail, String password) async {
    final FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(
        email: mail, password: password);
    return user;
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

  Future<FirebaseUser> signup(String mail, String password, String name) async {
    final FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(
        email: mail, password: password);
    String uid = user.uid;
    Map<String, String> map = {
      "uid": uid,
      "name": name,
    };
    addUser(uid, map);
    return user;
  }

  addUser(String uid, Map map) {
    base_user.child(uid).set(map);
  }
}
