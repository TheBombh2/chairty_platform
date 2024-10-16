import 'dart:io';


class Document {
  final String documentName;
  final File documentPath;
  String? docUrl;
  Document({required this.documentName, required this.documentPath});
  Map<String, dynamic> toJson() {
    return {
      'documentName': documentName,
      'documentPath': docUrl,
    };
  }

  

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      documentName: json['documentName'],
      documentPath: File(json['documentPath']),
    );
  }
}
