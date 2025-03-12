import 'dart:io';
import 'package:cricket_poc/lib_exports.dart';

final apiHeadersPr = Provider<ApiHeaders>(
  (ref) => ApiHeaders(localStorage: LocalStorage()),
);

class ApiHeaders {
  final LocalStorage _localStorage;

  ApiHeaders({required LocalStorage localStorage})
      : _localStorage = localStorage;

  final Map<String, String> headers = <String, String>{
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
  };

  ///Get Headers with Token
  Future<Map<String, String>> getHeadersWithToken() async {
    final token = await _localStorage.getJwtToken();
    // final token = await _localStorage.getJwtToken();

    return <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }
}
