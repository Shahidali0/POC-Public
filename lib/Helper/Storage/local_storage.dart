import 'dart:convert';

import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class LocalStorage {
  final String _kSignInJson = "SingInJson";

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  ///
  //* Login Details
  Future setLoginDetails({required SignInJson singInJson}) async {
    await deleteLoginDetails();
    await _storage.write(
      key: _kSignInJson,
      value: jsonEncode(singInJson),
    );

    debugPrint('Created Login Details and Token');
  }

  //* Get JWT Token
  Future<String?> getJwtToken() async {
    final signInJson = await getSignInResponse();

    return signInJson?.accessToken;
  }

  //* Get Login Data
  Future<SignInJson?> getSignInResponse() async {
    String? data = await _storage.read(key: _kSignInJson);

    if (data == null || data == "null") return null;

    Map<String, dynamic> jsonMap = jsonDecode(data);
    final signInJson = SignInJson.fromJson(jsonMap);

    return signInJson;
  }

  //* IsAuthorizes
  Future<bool> isAuthorized() async {
    final token = await getJwtToken();

    return token != null;
  }

  //! Delete Login Details
  Future deleteLoginDetails() async {
    await _storage.delete(key: _kSignInJson);

    debugPrint('Deleted Login Details and Token');
  }

  // //! Clear all data
  // Future deleteAll() async {
  //   await _storage.deleteAll();
  //   debugPrint('Deleted all');
  // }
}
