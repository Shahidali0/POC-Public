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
}

class _AuthServicesImpl extends AuthServices {
  final ApiHeaders _apiHeaders;

  _AuthServicesImpl({required ApiHeaders apiHeaders})
      : _apiHeaders = apiHeaders;

  ///Authenticate Vendor app
  @override
  Future<String?> authenticate({
    required String email,
    required String password,
  }) async {
    const url = "staging/login";

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
    );

    return response;
  }
}
