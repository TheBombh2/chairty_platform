import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatTile({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isMe ? Color(0xff034956) : Colors.grey.shade300,
          ),
          child: Text(
            message,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ));
  }
}
