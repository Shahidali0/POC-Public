import 'dart:convert';

import 'package:cricket_poc/lib_exports.dart';

final authServicesPr = Provider<AuthServices>(
  (ref) => _AuthServicesImpl(
    apiHeaders: ref.read(apiHeadersPr),
  ),
);

abstract class AuthServices {
  Future<String?> authenticate({
    required String email,
    required String password,
  });

  Future<String?> signUpUser({
    required SignUpDto signUpDto,
  });
  Future<String?> verifyOtp({
    required String email,
    required String otp,
  });
}

class _AuthServicesImpl extends AuthServices {
  final ApiHeaders _apiHeaders;

  _AuthServicesImpl({required ApiHeaders apiHeaders})
      : _apiHeaders = apiHeaders;

  //* Authenticate User
  @override
  Future<String?> authenticate({
    required String email,
    required String password,
  }) async {
    const url = "login";

    final body = jsonEncode(
      <String, dynamic>{
        "username": email,
        "password": password,
      },
    );

    final response = await BaseHttpClient.postService(
      urlEndPoint: url,
      body: body,
      headers: _apiHeaders.headers,
      isAuthUrl: true,
    );

    return response;
  }

//* SignUp User
  @override
  Future<String?> signUpUser({required SignUpDto signUpDto}) async {
    const url = "signup";

    final body = signUpDto.toRawJson();

    final response = await BaseHttpClient.postService(
      urlEndPoint: url,
      body: body,
      headers: _apiHeaders.headers,
      isAuthUrl: true,
    );

    return response;
  }

  //* Verify- Email & OTP
  @override
  Future<String?> verifyOtp(
      {required String email, required String otp}) async {
    const url = "confirm";

    final body = jsonEncode(
      <String, dynamic>{
        "username": email,
        "confirmationCode": otp,
      },
    );

    final response = await BaseHttpClient.postService(
      urlEndPoint: url,
      body: body,
      headers: _apiHeaders.headers,
      isAuthUrl: true,
    );

    return response;
  }
}
