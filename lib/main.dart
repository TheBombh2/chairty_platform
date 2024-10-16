import 'package:chairty_platform/cubits/messages/messages_cubit.dart';
import 'package:chairty_platform/firebase_options.dart';
import 'package:chairty_platform/screens/patient_request_form.dart';
import 'package:chairty_platform/cubits/requests/requests_cubit.dart';
import 'package:chairty_platform/screens/auth_screens/auth_screen.dart';
import 'package:chairty_platform/screens/patient_home_screen.dart';
import 'package:chairty_platform/stripe_payment/stripe_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  Stripe.publishableKey = Keys.publishKey;
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RequestsCubit()),
        BlocProvider(create: (context) => MessagesCubit()..getOtherUsers()),
      ],
      child: MaterialApp(
        theme: ThemeData(
        primaryColor: const Color(0xFF034956),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF034956),
          secondary: const Color(0xFFF26722),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6FAF7),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF034956)),
          bodyMedium: TextStyle(color: Color(0xFF034956)),
        ),
      ),
        debugShowCheckedModeBanner: false,
        home: const AuthScreen(),
        routes: {
          '/PatientRequest': (context) => const RequestAndEditScreen(),
          '/PatientHome': (context) => const PatientHomeScreen(),
        },
      ),
    );
  }
}
