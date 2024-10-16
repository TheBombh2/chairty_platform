enum UserType { donator, patient }

enum Gender { male, female }

class CharityUser {
  CharityUser({
    required this.userType,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.imageUrl,
    required this.bio,
    required this.wallet,
    required this.moneyRequested,
  });

  final String email;
  final UserType userType;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final Gender gender;
  final DateTime dateOfBirth;
  final String imageUrl;
  final String bio;
  final int wallet;
  final bool moneyRequested;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'type': userType.name,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'gender': gender.name, //
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'imageUrl': imageUrl,
      'bio': bio,
      'wallet':wallet,
      'moneyRequested':moneyRequested,
    };
  }

  factory CharityUser.fromJson(Map<String, dynamic> json) {
    return CharityUser(
      email: json['email'],
      userType: UserType.values.firstWhere((e) => e.name == json['type']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      gender: Gender.values.firstWhere((e) => e.name == json['gender']),
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      imageUrl: json['imageUrl'],
      bio: json['bio'],
      wallet:json['wallet'],
      moneyRequested: json['moneyRequested']
    );
  }
}
