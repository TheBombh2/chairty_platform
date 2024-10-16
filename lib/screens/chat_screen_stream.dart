import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Firebase/auth_interface.dart';
import '../components/chat_tile.dart';
import '../cubits/messages/messages_cubit.dart';
import '../models/message.dart';
import '../models/user.dart';

class ChatScreenStream extends StatelessWidget {
  final String patientId;
  final String donaterId;
  final CharityUser otherUser;

  const ChatScreenStream({
    super.key,
    required this.patientId,
    required this.donaterId,
    required this.otherUser,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    final ScrollController scrollController = ScrollController();
    CharityUser currentUser = AuthInterface.getCurrentCharityUser();

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
          'Chat',
          style: GoogleFonts.varelaRound(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff034956),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: context.read<MessagesCubit>().messagesStream(patientId,donaterId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No messages yet.'));
                  }

                  final messages = snapshot.data!;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollController.hasClients) {
                      scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    }
                  });

                  return ListView.builder(
                    controller: scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ChatTile(
                        message: message.message,
                        isMe: (message.sentBy == currentUser.userType),
                      );
                    },
                  );
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
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(width: 1, color: Color(0xff034956)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(width: 3, color: Color(0xff034956)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onSend,
                    icon: const Icon(
                      size: 35,
                      Icons.send,
                      color: Color(0xFFF26722),
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
