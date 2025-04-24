import 'dart:convert';

import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class LocalStorage {
  final String _kSignInJson = "SingInJson";
  final String _kShowIntro = "ShowIntro";

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  //* Get Show Intro
  Future<bool> getShowIntro() async {
    String? data = await _storage.read(key: _kShowIntro);

    if (data == null || data == "null") return true;

    return bool.parse(data);
  }

  //* Set Show Intro
  Future setShowIntro({required bool showIntro}) async {
    await _storage.write(
      key: _kShowIntro,
      value: showIntro.toString(),
    );

    debugPrint('Created Show Intro');
  }

  //* Login Details
  Future setLoginDetails({required SignInJson singInJson}) async {
    await deleteLoginDetails();

    //Store the login details
    await _storage.write(
      key: _kSignInJson,
      value: jsonEncode(singInJson),
    );

    //Store Show Intro Value
    await setShowIntro(showIntro: false);

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
