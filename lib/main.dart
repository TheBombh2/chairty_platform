import 'package:chairty_platform/screens/donator_home_screen.dart';
import 'package:chairty_platform/screens/patient_home_screen.dart';
import 'package:chairty_platform/screens/patient_request_form.dart';
import 'package:chairty_platform/stripe_payment/stripe_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


void main() {
  Stripe.publishableKey = Keys.publishKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DonatorHomeScreen(),
      routes: {
        '/PatientRequest': (context) => RequestAndEditScreen(),
        '/PatientHome': (context) => PatientHomeScreen(),
      },
    );
  }
}
