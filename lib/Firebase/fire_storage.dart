import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorageInterface {
  static FireStorageInterface? _firestoreInterface;
  FireStorageInterface._internal();
  factory FireStorageInterface() {
    return _firestoreInterface ?? FireStorageInterface._internal();
  }
  static final firebaseInstance = FirebaseStorage.instance;

  static Future<Reference> uploadUserPfp(String uid, File img) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_profile_pictures')
        .child('$uid.jpeg');
    await storageRef.putFile(img);
    return storageRef;

  }
}
