import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/models/document.dart';
import 'package:chairty_platform/models/place.dart';
import 'package:chairty_platform/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String? requestId;
  final String patientId;
  String? donaterId;
  final String reason;
  final String danger;
  final int funds;
  final List<Document> medicalDocuments;
  final String hospitalName;
  final PlaceLocation hospitalLocation;
  final DateTime deadline;
  bool requestCompleted;
  bool requestExpired;
  late CharityUser paitent;
  late CharityUser donater;

  Request({
    required this.patientId,
    required this.reason,
    required this.danger,
    required this.funds,
    required this.medicalDocuments,
    required this.hospitalName,
    required this.hospitalLocation,
    required this.deadline,
    this.requestCompleted = false,
    this.requestExpired = false,
    this.requestId,
    this.donaterId,
  });

  Future<void> initializePatient() async {
    final value = await FirestoreInterface.getDocumentFromCollectionByUid(
        'users', patientId);
    paitent = CharityUser.fromJson(value.data() as Map<String, dynamic>);
  }
  Future<void> initializeDonater() async {
    final value = await FirestoreInterface.getDocumentFromCollectionByUid(
        'users', donaterId!);
    donater = CharityUser.fromJson(value.data() as Map<String, dynamic>);
  }


  Future<void> uploadRequest() async{
    await FirestoreInterface.uploadRequest(toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'donaterId': donaterId,
      'reason': reason,
      'danger': danger,
      'funds': funds,
      'medicalDocuments': medicalDocuments.map((doc) => doc.toJson()).toList(),
      'hospitalName': hospitalName,
      'hospitalLocation': hospitalLocation.toJson(),
      'deadline': Timestamp.fromDate(deadline),
      'requestCompleted': requestCompleted,
      'expired':requestExpired
    };
  }

  factory Request.fromJson(Map<String, dynamic> json, String docId) {
    return Request(
      patientId: json['patientId'],
      reason: json['reason'],
      danger: json['danger'],
      funds: json['funds'],
      medicalDocuments: (json['medicalDocuments'] as List)
          .map((doc) => Document.fromJson(doc))
          .toList(),
      hospitalName: json['hospitalName'],
      hospitalLocation: PlaceLocation.fromJson(json['hospitalLocation']),
      deadline: (json['deadline'] as Timestamp).toDate(),
      requestId: docId,
      donaterId: json['donaterId'],
      requestCompleted: json['requestCompleted'] as bool,
      requestExpired:  json['expired'] as bool,
    );
  }
}
