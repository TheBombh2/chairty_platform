import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/models/user.dart';
import 'package:chairty_platform/screens/auth_screens/login_screen.dart';
import 'package:chairty_platform/screens/donator_home_screen.dart';
import 'package:chairty_platform/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<String> _getUserType(String uid) async {
      final document =
          await FirestoreInterface.getDocumentFromCollectionByUid('users', uid);

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

                if (userType  == UserType.donator.name) {
                  return const DonatorHomeScreen();
                } else {
                  return const ProfileScreen();
                }
              } else if (userTypeSnapshot.hasError) {
                AuthInterface.firebaseInstance.signOut();
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
