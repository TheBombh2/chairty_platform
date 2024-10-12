import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/components/drawer/drawer_menu.dart';
import 'package:chairty_platform/components/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Your Posts",
            style: GoogleFonts.varelaRound(
              color: const Color(
                0xffE2F1F2,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff034956),
          actions: [
            IconButton(
                onPressed: AuthInterface.firebaseInstance.signOut,
                icon: const Icon(
                  Icons.logout,
                  size: 40,
                  color: Colors.white,
                ))
          ],
          leading: Builder(builder: (ctx) {
            return IconButton(
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
              icon: const Icon(
                Icons.menu_rounded,
                size: 40,
                color: Color(
                  0xffE2F1F2,
                ),
              ),
            );
          }),
        ),
        drawer: const DrawerMenu(showHistory: false,),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/PatientRequest");
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: darkColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.red),
                          color: lightColor),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: deepOrange),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "100\$",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title : ............",
                                style: TextStyle(
                                  color: darkColor,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Description : ............",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  Positioned(
                    right: 10,
                    top: -15,
                    child: GestureDetector(
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: darkColor),
                          color: lightColor),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "100\$",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title : ............",
                                style: TextStyle(
                                  color: darkColor,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Description : ............",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  Positioned(
                    right: 10,
                    top: -15,
                    child: GestureDetector(
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
