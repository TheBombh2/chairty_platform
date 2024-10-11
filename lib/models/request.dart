import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String? requestId;
  final String patientId;
  String? donaterId;
  final String reason;
  final String danger;
  final int funds;
  final String medicalDocumentUrl;
  final String hospital;
  final String hospitalLocation;
  final DateTime deadline;
  bool requestCompleted;
  late CharityUser paitent;

  Request(
    this.reason,
    this.danger,
    this.funds,
    this.medicalDocumentUrl,
    this.hospital,
    this.hospitalLocation,
    this.deadline, {
    required this.patientId,
    this.requestId,
    this.donaterId,
    this.requestCompleted = false,
  });

  Future<void> initializePatient() async {
    final value = await FirestoreInterface.getDocumentFromCollectionByUid(
        'users', patientId);
    paitent = CharityUser.fromJson(value.data() as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'donaterId': donaterId,
      'reason': reason,
      'danger': danger,
      'funds': funds,
      'medicalDocumentUrl': medicalDocumentUrl,
      'hospital': hospital,
      'hospitalLocation': hospitalLocation,
      'deadline': Timestamp.fromDate(deadline),
      'requestCompleted': requestCompleted
    };
  }

  factory Request.fromJson(Map<String, dynamic> json, String docId) {
    return Request(
      json['reason'],
      json['danger'],
      json['funds'],
      json['medicalDocumentUrl'],
      json['hospital'],
      json['hospitalLocation'],
      (json['deadline'] as Timestamp).toDate(),
      patientId: json['patientId'],
      requestId: docId,
      donaterId: json['donaterId'],
      requestCompleted: json['requestCompleted'] ?? false,
    );
  }
}
