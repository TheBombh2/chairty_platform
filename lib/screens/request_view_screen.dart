import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/components/request_details_view/details_section.dart';
import 'package:chairty_platform/components/request_details_view/documents_list_section.dart';
import 'package:chairty_platform/components/request_details_view/donate_section.dart';
import 'package:chairty_platform/components/request_details_view/hospital_secion/hospital_details_secion.dart';
import 'package:chairty_platform/models/request.dart';
import 'package:chairty_platform/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestViewScreen extends StatelessWidget {
  const RequestViewScreen({super.key, required this.request});

  final Request request;

  @override
  Widget build(BuildContext context) {
    final paitent = request.paitent;
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF7),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          request.patientId == AuthInterface.getCurrentUser()!.uid
              ? 'Your Post'
              : "Donate to ${paitent.firstName + paitent.lastName}",
          style: GoogleFonts.varelaRound(
            color: const Color(
              0xffE2F1F2,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff034956),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Hero(
                tag: request.requestId!,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(paitent.imageUrl),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      paitent.firstName + paitent.lastName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.varelaRound(
                          color: const Color(
                            0xff034956,
                          ),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      textAlign: TextAlign.end,
                      '${DateTime.now().year - paitent.dateOfBirth.year} y.o',
                      style: GoogleFonts.varelaRound(
                          color: const Color(
                            0xff034956,
                          ),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              DetailsSection(
                title: 'Why do I need the donation',
                body: request.reason,
                backgroundColor: const Color.fromARGB(255, 247, 224, 157),
              ),
              const SizedBox(
                height: 16,
              ),
              DetailsSection(
                title: 'The danger that may affect me',
                body: request.danger,
                backgroundColor: const Color.fromARGB(255, 250, 122, 165),
              ),
              const SizedBox(
                height: 16,
              ),
              DocumentsListSection(
                documents: request.medicalDocuments,
              ),
              const SizedBox(
                height: 16,
              ),
              HospitalDetailsSecion(
                hospitalName: request.hospitalName,
                hospitalLocation: request.hospitalLocation,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                      user: paitent,
                                      viewOnly: true,
                                      patientId: request.patientId,
                                      donaterId: FirebaseAuth.instance.currentUser?.uid,
                                    ))),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 6, 144, 168),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Text(
                            "view profile",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              (request.patientId == AuthInterface.getCurrentUser()!.uid) ||
                      (request.requestCompleted)
                  ? const SizedBox.shrink()
                  : DonateSection(
                      amountNeeded: request.funds,
                    ),
              const SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
