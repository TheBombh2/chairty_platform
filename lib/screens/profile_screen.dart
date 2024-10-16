import 'package:chairty_platform/models/user.dart';
import 'package:chairty_platform/screens/chat_screen_stream.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen(
      {required this.user,
      required this.viewOnly,
      this.donaterId,
      this.patientId,
      super.key});

  final CharityUser user;
  final bool viewOnly;
  String? donaterId;
  String? patientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: viewOnly
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreenStream(
                            patientId: patientId!,
                            donaterId: donaterId!,
                            otherUser: user,
                          ))),
              backgroundColor: Color(0xFFF26722),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
            )
          : null,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          viewOnly ? user.firstName : "My Account",
          style: const TextStyle(
              color: Colors.white), // Set the title color to white
        ),
        backgroundColor:
            const Color(0xFF034956), // AppBar color from the palette
      ),
      body: Container(
        color: const Color(0xFFF6FAF7), // Background color from the palette
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Photo
            CircleAvatar(
              radius: 80, // Increased size
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            const SizedBox(height: 10), // Reduced space between elements

            // User Information Card
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 5), // Position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                    bottom: 20), // Added margin at the bottom
                child: SingleChildScrollView(
                  // Allow scrolling if content exceeds screen height
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align to the left
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: const TextStyle(
                          fontSize: 32, // Increased font size
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // User Details

                      _buildDetailRow(Icons.person,
                          "Gender: ${user.gender.name[0].toUpperCase() + user.gender.name.substring(1)}"),
                      _buildDetailRow(Icons.calendar_today,
                          "Date of Birth: ${user.dateOfBirth.day}/${user.dateOfBirth.month}/${user.dateOfBirth.year}"),
                      _buildDetailRow(
                          Icons.phone, "Phone: ${user.phoneNumber}"),
                      _buildDetailRow(Icons.email, "E-mail: ${user.email}"),
                      const SizedBox(height: 10),

                      // Description Section (Optional)
                      if (user.bio.isNotEmpty) ...[
                        const Text(
                          "Description:",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight:
                                  FontWeight.bold), // Increased text size
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user.bio,
                          style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black), // Increased text size
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            // Edit Profile Button
          ],
        ),
      ),
    );
  }

  // Helper method to build detail rows
  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFF26722)),
        // Updated icon color to match the button
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16, color: Colors.black), // Increased text size
          ),
        ),
      ],
    );
  }
}
