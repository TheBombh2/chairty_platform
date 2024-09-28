import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example user data
    final String type = "Donater"; // Donater or Patient
    final String firstName = "John";
    final String lastName = "Doe";
    final String gender = "Male";
    final String dateOfBirth = "01/01/1990";
    final String phoneNumber = "+1 234 567 890";
    final String email = "johndoe@example.com";
    final String description = "This is an optional description about the user.";
    final String profileImageUrl = "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"; // Updated image URL

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Account",
          style: TextStyle(color: Colors.white), // Set the title color to white
        ),
        backgroundColor: Color(0xFF034956), // AppBar color from the palette
      ),
      body: Container(
        color: Color(0xFFF6FAF7), // Background color from the palette
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Photo
            CircleAvatar(
              radius: 80, // Increased size
              backgroundImage: NetworkImage(profileImageUrl),
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
                margin: const EdgeInsets.only(bottom: 20), // Added margin at the bottom
                child: SingleChildScrollView( // Allow scrolling if content exceeds screen height
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
                    children: [
                      Text(
                        "$firstName $lastName",
                        style: const TextStyle(
                          fontSize: 32, // Increased font size
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // User Details
                      _buildDetailRow(Icons.people, "Type: $type"),
                      _buildDetailRow(Icons.person, "Gender: $gender"),
                      _buildDetailRow(Icons.calendar_today, "Date of Birth: $dateOfBirth"),
                      _buildDetailRow(Icons.phone, "Phone: $phoneNumber"),
                      _buildDetailRow(Icons.email, "E-mail: $email"),
                      const SizedBox(height: 10),

                      // Description Section (Optional)
                      if (description.isNotEmpty) ...[
                        const Text(
                          "Description:",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold), // Increased text size
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description,
                          style: const TextStyle(fontSize: 22, color: Colors.black), // Increased text size
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            // Edit Profile Button
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0), // Bottom padding for button
              child: ElevatedButton(
                onPressed: () {
                  // Action when button is pressed
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF034956), // Button color from the palette
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded button
                  ),
                ),
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 24,color: Colors.white), // Increased button text size

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build detail rows
  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFFF26722)), // Updated icon color to match the button
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.black), // Increased text size
          ),
        ),
      ],
    );
  }
}
