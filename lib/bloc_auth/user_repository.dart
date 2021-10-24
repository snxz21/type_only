import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserRepository()
      : _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp(String email, String password, String name, String phone, ) async {

    var aa = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _firebaseFirestore.collection("users").doc(aa.user.uid).set({
      "isPayment": false,
      "email": email,
      "name": name,
      "phone": phone,
      "tasksComplete": {},
    });
    return aa;
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser =  _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getUser() async {
     return await _firebaseAuth.currentUser;
  }

}
