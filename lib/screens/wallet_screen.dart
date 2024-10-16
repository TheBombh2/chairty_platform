import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chairty_platform/components/style.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'My Wallet',
            style: GoogleFonts.varelaRound(
              color: const Color(
                0xffE2F1F2,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff034956),
        ),
        body: StreamBuilder(
            stream: FirestoreInterface.firebaseInstance
                .collection('users')
                .doc(AuthInterface.getCurrentUser()!.uid)
                .snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                final isMoneyRequested = snapshot.data!['moneyRequested'];
                final currentWalletMoney = snapshot.data!['wallet'] as int;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '${snapshot.data!['wallet']}\$',
                        style: GoogleFonts.varelaRound(
                            color: darkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: (isMoneyRequested || currentWalletMoney <= 0)
                          ? null
                          : () async {
                              await FirestoreInterface.updateDataInUser(
                                  AuthInterface.getCurrentUser()!.uid,
                                  'moneyRequested',
                                  true);
                              await FirestoreInterface.updateDataInUser(
                                  AuthInterface.getCurrentUser()!.uid,
                                  'wallet',
                                  0);
                            },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: deepOrange),
                      child: Text(
                        'Make a withdrawl request.',
                        style: GoogleFonts.varelaRound(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    !isMoneyRequested
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'You have created a withdrawal request and will receive an email to continue the process.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.varelaRound(
                                color: darkColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                  ],
                );
              }

              return const CircularProgressIndicator();
            }));
  }
}
