import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  UserRepository() : _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  void aaa(b, {c, d}) {}

  Future<UserCredential> signUp({
    @required String email,
    @required String password,
    @required String firstName,
    @required String lastName,
    @required String userStatus,
  }) async {
    var regUserData = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    log('start');

    // _firebaseFirestore.collection("users").doc(regUserData.user.uid).set({
    //   "firstName": firstName,
    //   "lastName": lastName,
    //   "email": email,
    //   "userStatus": userStatus,
    // });
    log('end');
    return regUserData;
  }

  Future<bool> writeDBUserData({
    @required String email,
    @required UserCredential regUserData,
    @required String firstName,
    @required String lastName,
    @required String userStatus,
  }) async {
    await _firebaseFirestore.collection("users").doc(regUserData.user.uid).set({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "userStatus": userStatus,
    }).then(
      (value) {
        return true;
      },
      onError: (e) {
        log("error write $e");
        return false;
      },
    );
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getUser() async {
    return await _firebaseAuth.currentUser;
  }
}
