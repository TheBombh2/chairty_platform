import 'package:chairty_platform/models/request.dart';
import 'package:chairty_platform/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInterface {
  static List<Request> requests=[];
  static List<Request> allRequests=[];
  static List<CharityUser> patients=[];
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


  static Future<CharityUser?> getUserById(String uid) async {
    try {
      DocumentSnapshot doc = await firebaseInstance.collection('users').doc(uid).get();
      return CharityUser.fromJson(doc.data() as Map<String,dynamic>);
    } catch (e) {
      print("Error getting user: $e");
    }
    return null;
  }

  static Future<void> init(String uid) async {
    UserType? userType = (await getUserById(uid))!.userType;
    QuerySnapshot allRequestsSnapshot = await firebaseInstance
        .collection('requests')
        .get();
    allRequests = allRequestsSnapshot.docs.map((doc) {
      return Request.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
    if (userType == UserType.donator) {
      for(Request request in allRequests){
        if(request.donaterId==uid){
          requests.add(request);      //requests have been taken over by donater
        }
        CharityUser? patient=await getPatientByRequest(request.requestId!);
        patients.add(patient!);
      }
    } else if (userType == UserType.patient) {
      for(Request request in allRequests){
        if(request.patientId==uid){
          requests.add(request);    //requests for a certain patient
        }
      }
    } else {
      print("User type not found or not recognized.");
    }
  }

  static Future<void> addRequest(Request request) async {
    try {
      DocumentReference docRef = await firebaseInstance
          .collection('requests')
          .add(request.toJson());
      request.requestId = docRef.id;
      requests.add(request);
    } catch (e) {
      print('Error adding request: $e');
    }
  }

  static Future<void> deleteRequest(String requestId) async {
    try {
      await firebaseInstance
          .collection('requests')
          .doc(requestId)
          .delete();
      requests.removeWhere((request) => request.requestId == requestId);
    } catch (e) {
      print("Error deleting request: $e");
    }
  }
  static Future<void> takeOverRequest(String requestId, String donaterId) async {
    try {
      await firebaseInstance.collection('requests').doc(requestId).update(
          {
            'donaterId': donaterId,
            'requestCompleted': true,
          }
      );

      int requestIndex = requests.indexWhere((request) => request.requestId == requestId);
      requests[requestIndex].donaterId=donaterId;
      requests[requestIndex].requestCompleted=true;
    } catch (e) {
      print("Error taking over request: $e");
    }
  }
  static Future<CharityUser?> getPatientByRequest(String requestId) async {
    try {
      DocumentSnapshot requestDoc = await firebaseInstance.collection('requests').doc(requestId).get();
        String patientId = requestDoc['patientId'];
        DocumentSnapshot userDoc = await firebaseInstance.collection('users').doc(patientId).get();
          return CharityUser.fromJson(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print("Error getting patient by request: $e");
    }
    return null;
  }



}
