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
