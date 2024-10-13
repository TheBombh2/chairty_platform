import 'package:chairty_platform/screens/patient_request_form.dart';
import 'package:chairty_platform/cubits/requests/requests_cubit.dart';
import 'package:chairty_platform/screens/auth_screens/auth_screen.dart';
import 'package:chairty_platform/screens/patient_home_screen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/messages/messages_cubit.dart';
import 'firebase_options.dart';
void main() async {
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
        debugShowCheckedModeBanner: false,
        home: const AuthScreen(),
        routes: {
          '/PatientRequest': (context) => RequestAndEditScreen(),
          '/PatientHome': (context) => const PatientHomeScreen(),
        },
      ),
    );
  }
}
