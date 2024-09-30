import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class AuthInterface {
  static AuthInterface? _authInterface;
  AuthInterface._internal();
  factory AuthInterface() {
    return _authInterface ?? AuthInterface._internal();
  }
  static final firebaseInstance = FirebaseAuth.instance;

  static User? getCurrentUser() {
    return firebaseInstance.currentUser;
  }

  static Future<String> authinticateWithEmailAndPassword(
      String email, String password, bool isLogin) async {
    try {
      if (isLogin) {
        await firebaseInstance.signInWithEmailAndPassword(
            email: email, password: password);

        return 'Sign in Successful';
      } else {
        await firebaseInstance.createUserWithEmailAndPassword(
            email: email, password: password);
        return 'Sign up Successful';
      }
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Something went wrong.';
    }
  }

  static Future<void> signOut() async {
    return await firebaseInstance.signOut();
  }
}