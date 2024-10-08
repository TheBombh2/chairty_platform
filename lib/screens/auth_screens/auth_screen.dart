import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/screens/auth_screens/login_screen.dart';
import 'package:chairty_platform/screens/auth_screens/register_screen.dart';
import 'package:chairty_platform/screens/donator_home_screen.dart';
import 'package:chairty_platform/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<String> _getUserType(String uid) async {
      final document =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      return document.get('type') as String;
    }

    return StreamBuilder(
      stream: AuthInterface.firebaseInstance.authStateChanges(),
      builder: (ctx, snapshot) {
        late String userType;

        if (snapshot.hasData) {
          return FutureBuilder(
            future: _getUserType(snapshot.data!.uid),
            builder: (context, AsyncSnapshot<String> userTypeSnapshot) {
              if (userTypeSnapshot.hasData) {
                userType = userTypeSnapshot.data!;

                if (userType == 'Donator') {
                  return const DonatorHomeScreen();
                } else {
                  return const ProfileScreen();
                }
              } else if (userTypeSnapshot.hasError) {
                return Text('Error: ${userTypeSnapshot.error}');
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        }
        return const LoginScreen();
      },
    );
  }
}
