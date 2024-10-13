import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/screens/chat_screen_stream.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubits/messages/messages_cubit.dart';
import '../cubits/messages/messages_state.dart';
import '../models/user.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserType = AuthInterface.getCurrentCharityUser().userType;
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inbox",
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: const Color(0xffE2F1F2),
        centerTitle: true,
        backgroundColor: const Color(0xff034956),
      ),
      body: BlocBuilder<MessagesCubit, MessagesState>(
        builder: (context, state) {
          if (state is MessagesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MessagesLoaded) {
            if (state.otherUsers.isEmpty) {
              return const Center(child: Text('No Users Available.'));
            }

            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                itemCount: state.otherUsers.length,
                itemBuilder: (ctx, index) {
                  final CharityUser otherUser = state.otherUsers[index].keys.first!;

                  return Card(
                    surfaceTintColor: const Color(0xffE2F1F2),
                    shadowColor: const Color(0xff034956),
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white,
                    child: ListTile(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFFF26722)),
                      ),
                      onTap: () {
                        // Navigate to ChatScreenStream
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreenStream(
                              otherUser: otherUser,
                              donaterId: currentUserType == UserType.donator ? currentUserId : state.otherUsers[index][otherUser]!,
                              patientId: currentUserType == UserType.patient ? currentUserId : state.otherUsers[index][otherUser]!,
                            ),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(otherUser.imageUrl),
                      ),
                      title: Text(
                        "${otherUser.firstName} ${otherUser.lastName}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff034956),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chat,
                        size: 30,
                        color: Color(0xFFF26722),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is MessagesError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
