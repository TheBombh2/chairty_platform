import 'package:chairty_platform/screens/donator_home_screen.dart';
import 'package:chairty_platform/screens/patient_home_screen.dart';
import 'package:chairty_platform/screens/patient_request_form.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PatientHomeScreen(),
      routes: {
        '/PatientRequest': (context) => RequestAndEditScreen(),
        '/PatientHome': (context) => PatientHomeScreen(),
      },
    );
  }
}
