import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/components/chat_tile.dart';
import 'package:chairty_platform/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubits/messages/messages_cubit.dart';
import '../cubits/messages/messages_state.dart';
import '../models/user.dart';

class ChatScreen extends StatelessWidget {
  final String patientId;
  final String donaterId;
  final CharityUser otherUser;

  const ChatScreen({required this.patientId, required this.donaterId,required this.otherUser});

  @override
  Widget build(BuildContext context) {

    TextEditingController messageController = TextEditingController();
    CharityUser currentUser=AuthInterface.getCurrentCharityUser();
    void onSend() {
      if (messageController.text.isNotEmpty) {
        Message message = Message(
          sentBy: currentUser.userType,
          donaterId: donaterId,
          patientId: patientId,
          message: messageController.text,
        );
        context.read<MessagesCubit>().sendMessage(message);
        messageController.clear();

      }
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xffE2F1F2),
        title: Text(
          'chat',
          style: GoogleFonts.varelaRound(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff034956),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<MessagesCubit, MessagesState>(
                builder: (context, state) {
                  if (state is MessagesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MessagesLoaded) {
                    return ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return ChatTile(message: message.message, isMe: (message.sentBy==currentUser.userType));
                      },
                    );
                  } else if (state is MessagesError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Container(); // Fallback UI
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Enter your message...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 1, color: Colors.teal),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 3, color: Colors.teal),
                        ),
                      ),
                    ),
                  ),
                  // Send button
                  IconButton(
                    onPressed: onSend,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
