library auth_service;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth _dbInit = FirebaseAuth.instance;

  Stream<User> get userStatus => _dbInit.authStateChanges();

  Future signUpWithEmail(
      {@required String email, @required String password}) async {
    try {
      return await _dbInit
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (userData) {
          if (!userData.user.emailVerified) {
            verifyEmail();
          }
          print(userData.user.emailVerified);
          return userData.user.uid;
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return "Failed";
    }
  }

  Future verifyEmail() async {
    User user = _dbInit.currentUser;
    await user.sendEmailVerification();
  }

  Future signInWithEmail(
      {@required String email, @required String password}) async {
    try {
      return await _dbInit
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (userData) {
          if (!userData.user.emailVerified) {
            verifyEmail();
          }
          return userData.user.uid;
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return "Failed";
    }
  }

  signoutUser() {
    return _dbInit.signOut();
  }
}
