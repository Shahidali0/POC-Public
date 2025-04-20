import 'dart:convert';

class UsersResponseJson {
  final UserJson? user;

  UsersResponseJson({
    this.user,
  });

  UsersResponseJson copyWith({
    UserJson? user,
  }) =>
      UsersResponseJson(
        user: user ?? this.user,
      );

  factory UsersResponseJson.fromRawJson(String str) =>
      UsersResponseJson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsersResponseJson.fromJson(Map<String, dynamic> json) =>
      UsersResponseJson(
        user: json["user"] == null ? null : UserJson.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class UserJson {
  final String? suburb;
  final String? userType;
  final String? lastName;
  final String? userId;
  final String? goal;
  final String? username;
  final String? abn;
  final String? firstName;

  UserJson({
    this.suburb,
    this.userType,
    this.lastName,
    this.userId,
    this.goal,
    this.username,
    this.abn,
    this.firstName,
  });

  UserJson copyWith({
    String? suburb,
    String? userType,
    String? lastName,
    String? userId,
    String? goal,
    String? username,
    String? abn,
    String? firstName,
  }) =>
      UserJson(
        suburb: suburb ?? this.suburb,
        userType: userType ?? this.userType,
        lastName: lastName ?? this.lastName,
        userId: userId ?? this.userId,
        goal: goal ?? this.goal,
        username: username ?? this.username,
        abn: abn ?? this.abn,
        firstName: firstName ?? this.firstName,
      );

  factory UserJson.fromRawJson(String str) =>
      UserJson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserJson.fromJson(Map<String, dynamic> json) => UserJson(
        suburb: json["suburb"],
        userType: json["userType"],
        lastName: json["lastName"],
        userId: json["userId"],
        goal: json["goal"],
        username: json["username"],
        abn: json["abn"],
        firstName: json["firstName"],
      );

  Map<String, dynamic> toJson() => {
        "suburb": suburb,
        "userType": userType,
        "lastName": lastName,
        "userId": userId,
        "goal": goal,
        "username": username,
        "abn": abn,
        "firstName": firstName,
      };
}
