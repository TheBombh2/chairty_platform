import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/models/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

Color darkColor = HexColor("#034956");
Color lightColor = HexColor("#E2F1F2");
Color deepOrange = HexColor("#F26722");

var idController = TextEditingController();
var reasonController = TextEditingController();
var dangerController = TextEditingController();
var fundsController = TextEditingController();
var docsController = TextEditingController();
var hospitalController = TextEditingController();
var locationController = TextEditingController();
var deadLineController = TextEditingController();

class RequestAndEditScreen extends StatelessWidget {
  RequestAndEditScreen({super.key});
  DateTime? pickedDate;
  User? user = FirebaseAuth.instance.currentUser;
  void onSubmit(){
    Request newRequest=Request(reasonController.text, dangerController.text, int.parse(fundsController.text)
        , docsController.text, hospitalController.text, locationController.text, pickedDate!, patientId:"hZTgPOEhOgXiGa1EEdZhmKUlGE32" );//patientId:user!.uid
    FirestoreInterface.addRequest(newRequest);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Request",
              style: TextStyle(
                  color: darkColor, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: lightColor, borderRadius: BorderRadius.circular(20)),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FormFields(
                              controller: idController,
                              type: TextInputType.number,
                              hint: "Owner ID",
                              label: "Owner ID",
                              icon: Icons.person),
                          const SizedBox(
                            height: 20,
                          ),
                          FormFields(
                            controller: reasonController,
                            type: TextInputType.multiline,
                            maxLines: 6,
                            hint: "Reason",
                            label: "Your Reason",
                            icon: Icons.question_mark_outlined,
                            isMultilineText: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormFields(
                            controller: dangerController,
                            type: TextInputType.multiline,
                            maxLines: 6,
                            hint: "Danger",
                            label: "Danger",
                            icon: Icons.dangerous,
                            isMultilineText: true,
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
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormFields(
                            controller: docsController,
                            type: TextInputType.text,
                            hint: "DOCs",
                            label: "Your Medical DOCs Link",
                            icon: Icons.picture_as_pdf,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormFields(
                            controller: hospitalController,
                            type: TextInputType.text,
                            hint: "Hospital",
                            label: "Hospital Name",
                            icon: Icons.location_city,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormFields(
                            controller: locationController,
                            type: TextInputType.text,
                            hint: "Location",
                            label: "Hospital Location",
                            icon: Icons.location_on_rounded,
                          ),
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
                              FocusScope.of(context).requestFocus(FocusNode()); // Prevent keyboard from appearing
                              pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2030-10-25'),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: darkColor, // Color for selected dates
                                      colorScheme: ColorScheme.light(
                                        primary: deepOrange, // Header background color
                                        onPrimary: Colors.white, // Header text color
                                        onSurface: darkColor, // Body text color
                                      ),
                                      dialogBackgroundColor: Colors.blueGrey[50], // Background color of the picker
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                deadLineController.text = DateFormat.yMMMd().format(pickedDate!);
                                print(DateFormat.yMMMd().format(pickedDate!));
                              }
                            },
                            isDateField: true, // Custom flag to handle date fields
                          ),

                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () =>onSubmit(),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: darkColor),
                                child:  const Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

Widget FormFields({
  required TextEditingController controller,
  required TextInputType type,
  required String hint,
  required String label,
  required IconData icon,
  bool isMultilineText = false,
  bool isDateField = false, // New flag
  double? hight,
  int? maxLines,
  Function? onTap,
}) =>
    SizedBox(
      height: hight,
      child: TextField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        textAlignVertical: TextAlignVertical.top,
        readOnly: isDateField, // Make read-only for date fields
        onTap: isDateField ? () => onTap!() : null, // Trigger onTap only if date field
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
              )),
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
