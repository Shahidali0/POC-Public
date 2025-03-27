import 'dart:convert';
import 'dart:io';

import 'package:cricket_poc/lib_exports.dart';
import 'package:fpdart/fpdart.dart';

final authRepositoryPr = Provider<AuthRepository>(
  (ref) => AuthRepository(
    authServices: ref.read(authServicesPr),
    // localStorage: LocalStorage(),
  ),
);

class AuthRepository {
  final AuthServices _authServices;

  AuthRepository({
    required AuthServices authServices,
  }) : _authServices = authServices;

  ///Authenticate
  FutureEither<bool> authenticateUser({
    required String emailId,
    required String password,
  }) async {
    try {
      bool isSignedIn = false;

      final signInResult = await _authServices.authenticate(
        email: emailId,
        password: password,
      );

      if (signInResult != null) {
        // final signInData = SignInJson.fromRawJson(signInResult);
        // await _localStorage.setLoginDetails(signInData);
        isSignedIn = true;
      }

      return right(isSignedIn);
    } on SocketException {
      return left(AppExceptions.instance.handleSocketException());
    } on MyHttpClientException catch (error) {
      ///Here --> error type: Failure
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (error) {
      return left(
          AppExceptions.instance.handleException(error: error.toString()));
    }
  }

  ///SignUp User
  FutureEither<String> signUpUser({
    required SignUpDto dto,
  }) async {
    try {
      String message = '';

      final signUpResult = await _authServices.signUpUser(signUpDto: dto);

      if (signUpResult != null) {
        final signUpData = jsonDecode(signUpResult);
        message = signUpData["message"];
      }

      return right(message);
    } on SocketException {
      return left(AppExceptions.instance.handleSocketException());
    } on MyHttpClientException catch (error) {
      ///Here --> error type: Failure
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (error) {
      return left(
          AppExceptions.instance.handleException(error: error.toString()));
    }
  }

  ///Verify Otp and SignIn
  FutureEither<String> verifyOtpAndSignIn({
    required String email,
    required String otp,
  }) async {
    try {
      String message = "";

      final otpResult = await _authServices.verifyOtp(
        email: email,
        otp: otp,
      );

      if (otpResult != null) {
        final signUpData = jsonDecode(otpResult);
        message = signUpData["message"];
      }

      return right(message);
    } on SocketException {
      return left(AppExceptions.instance.handleSocketException());
    } on MyHttpClientException catch (error) {
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (error) {
      return left(
          AppExceptions.instance.handleException(error: error.toString()));
    }
  }
}
