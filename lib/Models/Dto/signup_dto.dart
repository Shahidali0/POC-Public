import 'dart:convert';

class SignUpDto {
  final String? username;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? suburb;
  final String? goal;
  final String? userType;
  final String? abn;

  SignUpDto({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.suburb,
    required this.goal,
    required this.userType,
    required this.abn,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "suburb": suburb,
        "goal": goal,
        "userType": userType,
        "abn": abn,
      };
}



// ///Registered as user
// class UserRegistrationDto {
//   final String fullName;
//   final String email;
//   final String phoneNumber;
//   final String idType;
//   final String idNumber;
//   final String address;
//   final bool isValidated;

//   UserRegistrationDto({
//     required this.fullName,
//     required this.email,
//     required this.phoneNumber,
//     required this.idType,
//     required this.idNumber,
//     required this.address,
//     required this.isValidated,
//   });
// }

// ///Registered as provider
// class ProviderRegistrationDto {
//   final String fullName;
//   final String businessName;
//   final String email;
//   final String phoneNumber;
//   final String yearsOfExperience;
//   final String specialization;
//   final String idType;
//   final String idNumber;
//   final String taxIdNumber;
//   final String businessAddress;
//   final bool isValidated;

//   ProviderRegistrationDto({
//     required this.fullName,
//     required this.businessName,
//     required this.email,
//     required this.phoneNumber,
//     required this.yearsOfExperience,
//     required this.specialization,
//     required this.idType,
//     required this.idNumber,
//     required this.taxIdNumber,
//     required this.businessAddress,
//     required this.isValidated,
//   });
// }
