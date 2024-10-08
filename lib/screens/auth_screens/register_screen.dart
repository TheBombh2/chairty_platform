import 'dart:io';

import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/components/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  String _selectedFirstName = '';
  String _selectedLastName = '';
  String _selectedType = 'Donator';
  DateTime? _selectedDateOfBirth;
  String _selectedGender = 'Male';
  String _selectedPhoneNumber = '';
  String _enteredEmail = '';
  String _enteredPassword = '';
  bool _isAuthenticating = false;

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

      await AuthInterface.authinticateWithEmailAndPassword(
        _enteredEmail,
        _enteredPassword,
        false,
      );
      final userUid = AuthInterface.getCurrentUser()!.uid;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_profile_pictures')
          .child('${userUid}.jpeg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(
            userUid,
          )
          .set({
        'email': _enteredEmail,
        'type': _selectedType,
        'first_name': _selectedFirstName,
        'last_name': _selectedLastName,
        'phone_number': _selectedPhoneNumber,
        'gender': _selectedGender,
        'date_of_birth': _selectedDateOfBirth,
        'profile_picture-url': imageUrl
      });
      setState(() {
        _isAuthenticating = false;
      });
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isAuthenticating = false;
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed')));
    } catch (error) {
      setState(() {
        _isAuthenticating = false;
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong.')));
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
        title: Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserImagePicker(onPickImage: (pickedImage) {
                _selectedImage = pickedImage;
              }),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'First name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter a valid first name';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                _selectedFirstName = newValue!;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Last name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter a valid last name';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                _selectedLastName = newValue!;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              value: 'Donator',
                              items: const [
                                DropdownMenuItem(
                                    value: 'Donator', child: Text('Donator')),
                                DropdownMenuItem(
                                    value: 'Paitent', child: Text('Paitent')),
                              ],
                              onChanged: (value) {
                                _selectedType = value!;
                              },
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _selectedDateOfBirth == null
                                      ? 'Date of Birth'
                                      : formatter.format(_selectedDateOfBirth!),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  onPressed: _presentDatePicker,
                                  icon: const Icon(
                                    Icons.calendar_month,
                                    size: 32,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              value: 'Male',
                              items: const [
                                DropdownMenuItem(
                                    value: 'Male', child: Text('Male')),
                                DropdownMenuItem(
                                    value: 'Female', child: Text('Female')),
                              ],
                              onChanged: (value) {
                                _selectedGender = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Phone number',
                                prefix: Text('+20'),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    int.tryParse(value) == null) {
                                  return 'Enter a valid phone number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _selectedPhoneNumber = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredEmail = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return 'Enter a valid password';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredPassword = newValue!;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: _isAuthenticating ? null : _submit,
                      child: _isAuthenticating
                          ? const CircularProgressIndicator()
                          : const Text("Register"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
