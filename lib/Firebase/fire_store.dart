import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInterface {
  static FirestoreInterface? _firestoreInterface;
  FirestoreInterface._internal();
  factory FirestoreInterface() {
    return _firestoreInterface ?? FirestoreInterface._internal();
  }
  static final firebaseInstance = FirebaseFirestore.instance;

  static registerNewUser(String userUid, Map<String, dynamic> data) async {
    await firebaseInstance
        .collection('users')
        .doc(
          userUid,
        )
        .set(data);
  }

  static Future<DocumentSnapshot> getDocumentFromCollectionByUid(
      String collection, String uid) async {
    return await firebaseInstance.collection(collection).doc(uid).get();
  }
}
