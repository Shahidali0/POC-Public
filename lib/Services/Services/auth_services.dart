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

  Future<String?> forgotPassword({
    required String email,
  });

  Future<String?> confirmForgotPassword({
    required String email,
    required String otp,
    required String newPassword,
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

  //* Forgot Password
  @override
  Future<String?> forgotPassword({required String email}) async {
    const url = "forgotPassword";

    final body = jsonEncode(
      <String, dynamic>{
        "username": email,
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

  //* Update New Password to DB
  @override
  Future<String?> confirmForgotPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    const url = "confirmForgotPassword";

    final body = jsonEncode(
      <String, dynamic>{
        "username": email,
        "confirmationCode": otp,
        "newPassword": newPassword,
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
