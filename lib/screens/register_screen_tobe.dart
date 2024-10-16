import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Added import



class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF7),
      appBar: AppBar(
        title: const Text(
          'Select User Type',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Are you a Donator or a Patient?',
                style: TextStyle(fontSize: 20, color: Color(0xFF034956)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const RegistrationScreen(type: 'Donator'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text('I am a Donator'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const RegistrationScreen(type: 'Patient'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text('I am a Patient'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  final String type;

  const RegistrationScreen({Key? key, required this.type}) : super(key: key);

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker(); // Correct usage
  XFile? _selectedImage; // Correct usage of XFile

  String? _firstName;
  String? _lastName;
  String? _gender;
  String? _phoneNumber;
  String? _email;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Registration'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Text(
                widget.type == 'Donator'
                    ? 'Thank you for choosing to help others!'
                    : 'We are here to help you!',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF034956),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              // First Name Field
              TextFormField(
                decoration: const InputDecoration(labelText: 'First Name'),
                onSaved: (value) {
                  _firstName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  // Regular expression to allow only alphabets and spaces
                  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    return 'Please enter a valid name (only characters allowed)';
                  }
                  return null;
                },
              ),
              // Last Name Field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                onSaved: (value) {
                  _lastName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  // Regular expression to allow only alphabets and spaces
                  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    return 'Please enter a valid name (only characters allowed)';
                  }
                  return null;
                },
              ),
              // Gender Field
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Gender'),
                value: _gender,
                items: ['Male', 'Female', 'Other']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select gender' : null,
              ),
              // Phone Number Field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _phoneNumber = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  // Ensure phone number is exactly 11 digits
                  if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                    return 'Phone number must be exactly 11 digits';
                  }
                  return null;
                },
              ),
              // Email Field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              // Description Field (Optional)
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Description (Optional)'),
                onSaved: (value) {
                  _description = value;
                },
              ),
              const SizedBox(height: 20),
              Text(
                _selectedImage == null
                    ? 'No image selected.'
                    : 'Image selected: ${_selectedImage!.name}',
                style: const TextStyle(color: Color(0xFF034956)),
              ),
              ElevatedButton(
                onPressed: () async {
                  final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery); // Correct usage
                  setState(() {
                    _selectedImage = image;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text('Upload Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('First Name: $_firstName');
                    print('Last Name: $_lastName');
                    print('Phone Number: $_phoneNumber');
                    print('Email: $_email');
                    print('Description: $_description');

                    // Form submission logic
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Success'),
                        content:
                            const Text('Your information has been submitted!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
