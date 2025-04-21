// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignInJson {
  final String? message;
  final String? accessToken;
  final String? idToken;
  final String? refreshToken;

  ///For Internal
  final String? emailId;
  final String? password;

  SignInJson({
    this.message,
    this.accessToken,
    this.idToken,
    this.refreshToken,
    this.emailId,
    this.password,
  });

  factory SignInJson.fromRawJson(String str) =>
      SignInJson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignInJson.fromJson(Map<String, dynamic> json) => SignInJson(
        message: json["message"],
        accessToken: json["accessToken"],
        idToken: json["idToken"],
        refreshToken: json["refreshToken"],
        emailId: json["emailId"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "accessToken": accessToken,
        "idToken": idToken,
        "refreshToken": refreshToken,
        "emailId": emailId,
        "password": password,
      };

  SignInJson copyWith({
    String? message,
    String? accessToken,
    String? idToken,
    String? refreshToken,
    String? emailId,
    String? password,
  }) {
    return SignInJson(
      message: message ?? this.message,
      accessToken: accessToken ?? this.accessToken,
      idToken: idToken ?? this.idToken,
      refreshToken: refreshToken ?? this.refreshToken,
      emailId: emailId ?? this.emailId,
      password: password ?? this.password,
    );
  }
}
