import 'package:chairty_platform/models/user.dart';

class Message {
  final String patientId;
  final String donaterId;
  final String message;
  final UserType sentBy;
  final DateTime timestamp;

  Message({
    required this.sentBy,
    required this.donaterId,
    required this.patientId,
    required this.message,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'sentBy':sentBy.name,
      'patientId': patientId,
      'donaterId': donaterId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sentBy:UserType.values.firstWhere((e) => e.name == json['sentBy']),
      patientId: json['patientId'],
      donaterId: json['donaterId'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
