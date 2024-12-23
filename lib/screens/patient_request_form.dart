import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/Firebase/fire_storage.dart';
import 'package:chairty_platform/components/google_map/location_input.dart';
import 'package:chairty_platform/components/medical_docs_field/medical_docs_field.dart';
import 'package:chairty_platform/models/document.dart';
import 'package:chairty_platform/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:chairty_platform/models/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/style.dart';

class RequestAndEditScreen extends StatefulWidget {
  const RequestAndEditScreen({super.key});

  @override
  State<RequestAndEditScreen> createState() => _RequestAndEditScreenState();
}

class _RequestAndEditScreenState extends State<RequestAndEditScreen> {
  var reasonController = TextEditingController();
  var dangerController = TextEditingController();
  var fundsController = TextEditingController();
  var hospitalNameController = TextEditingController();
  var deadLineController = TextEditingController();
  final List<Document> uploadedMedicalDocuments = [];
  DateTime? pickedDate;

  User? user = FirebaseAuth.instance.currentUser;

  PlaceLocation? _selectedHospitalLocation;
  final _formKey = GlobalKey<FormState>();

  bool isUploading = false;

  void onSubmit() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (uploadedMedicalDocuments.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('You must at least upload one medical report.'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: (const Text('OK')))
            ],
          ),
        ),
      );
      return;
    }
    if (_selectedHospitalLocation == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('You must select hospital location.'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: (const Text('OK')))
            ],
          ),
        ),
      );
      return;
    }
    if (pickedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('You must select deadline date of your request'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: (const Text('OK')))
            ],
          ),
        ),
      );
      return;
    }
    Request newRequest = Request(
      patientId: AuthInterface.getCurrentUser()!.uid,
      reason: reasonController.text,
      danger: dangerController.text,
      funds: int.parse(fundsController.text),
      medicalDocuments: uploadedMedicalDocuments,
      hospitalName: hospitalNameController.text,
      hospitalLocation: _selectedHospitalLocation!,
      deadline: pickedDate!,
    );
    setState(() {
      isUploading = true;
    });
    for (var ele in newRequest.medicalDocuments) {
      final url =
          await FireStorageInterface.uploadMedicalDocument(ele.documentPath);
      ele.docUrl = await url.getDownloadURL();
    }

    await newRequest.uploadRequest();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request Uploaded Successfully.')));
    uploadedMedicalDocuments.clear();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    reasonController.dispose();
    dangerController.dispose();
    fundsController.dispose();
    hospitalNameController.dispose();
    deadLineController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Fill Request Form",
            style: GoogleFonts.varelaRound(
              color: const Color(
                0xffE2F1F2,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff034956),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: lightColor),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          FormFields(
                            controller: reasonController,
                            type: TextInputType.multiline,
                            maxLines: 6,
                            hint: "Reason",
                            label: "Why do you need help?",
                            icon: Icons.question_mark_outlined,
                            isMultilineText: true,
                            onValidate: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 100) {
                                return 'Reason must be at least 100 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormFields(
                            controller: dangerController,
                            type: TextInputType.multiline,
                            maxLines: 6,
                            hint: "Danger",
                            label: "What is the danger?",
                            icon: Icons.dangerous,
                            isMultilineText: true,
                            onValidate: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 100) {
                                return 'Danger must be at least 100 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormFields(
                            controller: fundsController,
                            type: TextInputType.number,
                            hint: "Funds",
                            label: "Funds",
                            icon: Icons.money,
                            onValidate: (value) {
                              final number = int.tryParse(value!);
                              if (number == null || number <= 0) {
                                return 'Enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MedicalDocsField(
                            uploadedDocuments: uploadedMedicalDocuments,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormFields(
                            controller: hospitalNameController,
                            type: TextInputType.text,
                            hint: "Hospital",
                            label: "Hospital Name",
                            icon: Icons.location_city,
                            onValidate: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 5) {
                                return 'Hospital name must be at least 5 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LocationInput(onSelectLocation: (location) {
                            _selectedHospitalLocation = location;
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          FormFields(
                            controller: deadLineController,
                            type: TextInputType.datetime,
                            hint: "Deadline",
                            label: "Deadline",
                            icon: Icons.date_range,
                            onTap: () async {
                              FocusScope.of(context).requestFocus(
                                  FocusNode()); // Prevent keyboard from appearing
                              pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2030-10-25'),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor:
                                          darkColor, // Color for selected dates
                                      colorScheme: ColorScheme.light(
                                        primary:
                                            deepOrange, // Header background color
                                        onPrimary:
                                            Colors.white, // Header text color
                                        onSurface: darkColor, // Body text color
                                      ),
                                      dialogBackgroundColor: Colors.blueGrey[
                                          50], // Background color of the picker
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                deadLineController.text =
                                    DateFormat.yMMMd().format(pickedDate!);
                                print(DateFormat.yMMMd().format(pickedDate!));
                              }
                            },
                            isDateField:
                                true, // Custom flag to handle date fields
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          isUploading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: onSubmit,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: darkColor),
                                  child: const Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

Widget FormFields({
  required TextEditingController controller,
  required TextInputType type,
  required String hint,
  required String label,
  required IconData icon,
  String? Function(String?)? onValidate,
  bool isMultilineText = false,
  bool isDateField = false, // New flag
  double? hight,
  int? maxLines,
  Function? onTap,
}) =>
    SizedBox(
      height: hight,
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        textAlignVertical: TextAlignVertical.top,
        readOnly: isDateField, // Make read-only for date fields
        validator: onValidate,
        onTap: isDateField
            ? () => onTap!()
            : null, // Trigger onTap only if date field
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: darkColor,
                width: 2,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: deepOrange,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          hintText: hint,
          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: darkColor),
          labelText: label,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          alignLabelWithHint: true,
          prefixIcon: isMultilineText
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                  child: Icon(
                    icon,
                    color: deepOrange,
                  ),
                )
              : Icon(
                  icon,
                  color: deepOrange,
                ),
        ),
      ),
    );
