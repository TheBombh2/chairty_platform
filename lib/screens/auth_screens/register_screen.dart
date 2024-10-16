import 'dart:io';

import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/Firebase/fire_storage.dart';
import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/models/user.dart';
import 'package:chairty_platform/screens/auth_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Added import
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

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
  String? _password;
  String? _description;
  DateTime? _selectedDateOfBirth;
  bool _isAuthenticating = false;
  bool _isPasswordVisible = false;

  void _submit() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid || _selectedImage == null || _selectedDateOfBirth == null) {
      return;
    }
    _formKey.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });

      final message = await AuthInterface.authinticateWithEmailAndPassword(
        _email!,
        _password!,
        false,
      );
      if (message.startsWith('error')) {
        final dashIndex = message.indexOf('-');
        throw FirebaseAuthException(
            code: 'bad', message: message.substring(dashIndex + 1));
      }

      final userUid = AuthInterface.getCurrentUser()!.uid;
      final storageRef = await FireStorageInterface.uploadUserPfp(
          userUid, File(_selectedImage!.path));

      final imageUrl = await storageRef.getDownloadURL();
      final _selectedType = widget.type.toLowerCase() == UserType.patient.name
          ? UserType.patient
          : UserType.donator;
      final _selectedGender =
          _gender!.toLowerCase() == Gender.male.name ? Gender.male : Gender.female;

      await FirestoreInterface.registerNewUser(
          userUid,
          CharityUser(
                  userType: _selectedType,
                  email: _email!,
                  firstName: _firstName!,
                  lastName: _lastName!,
                  gender: _selectedGender,
                  phoneNumber: _phoneNumber!,
                  dateOfBirth: _selectedDateOfBirth!,
                  imageUrl: imageUrl,
                  bio: _description!,
                  wallet: 0,
                  moneyRequested: false)
              .toJson());

      setState(() {
        _isAuthenticating = false;
      });
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const LoginScreen()));
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isAuthenticating = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? 'Authentication failed')));
      }
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(1930);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDateOfBirth = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Registration',style: const TextStyle(color: Colors.white),),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDateOfBirth == null
                        ? 'Date of Birth'
                        : formatter.format(_selectedDateOfBirth!),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(
                      Icons.calendar_month,
                      size: 32,
                    ),
                  )
                ],
              ),
              // Gender Field
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Gender'),
                value: _gender,
                items: ['Male', 'Female']
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
              TextFormField(
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                onSaved: (value) {
                  _password = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Please enter at least 6 characters valid password ';
                  }
                  // Regular expression to allow only alphabets and spaces

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
                onPressed: _isAuthenticating ? null : _submit,
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
