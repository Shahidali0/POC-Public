import 'dart:convert';
import 'dart:io';

import 'package:cricket_poc/lib_exports.dart';
import 'package:fpdart/fpdart.dart';

final authRepositoryPr = Provider<AuthRepository>(
  (ref) => AuthRepository(
    authServices: ref.read(authServicesPr),
    localStorage: LocalStorage(),
  ),
);

final autoSignInPr = FutureProvider<bool>((ref) async {
  final authRepository = ref.read(authRepositoryPr);
  return await authRepository.autoSignIn();
});

class AuthRepository {
  final AuthServices _authServices;
  final LocalStorage _localStorage;

  AuthRepository({
    required AuthServices authServices,
    required LocalStorage localStorage,
  })  : _authServices = authServices,
        _localStorage = localStorage;

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
        ///Parse the json
        final parsedData = SignInJson.fromRawJson(signInResult);

        ///Now Copy EmailId and Password to the SignInJson
        final data = parsedData.copyWith(emailId: emailId, password: password);

        ///Save the LoginDetails in local storage
        await _localStorage.setLoginDetails(singInJson: data);

        // return left(AppExceptions.instance.handleSocketException());

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

  ///Automatically SignIn
  Future<bool> autoSignIn() async {
    try {
      bool isAutoSignIn = false;
      final signInResult = await _localStorage.getSignInResponse();

      ///Check if the user details are not null
      if (signInResult == null ||
          signInResult.emailId == null ||
          signInResult.password == null) return false;

      ///Authenticate the user
      final data = await authenticateUser(
        emailId: signInResult.emailId!,
        password: signInResult.password!,
      );

      data.fold(
        (failure) => isAutoSignIn = false,
        (success) => isAutoSignIn = success,
      );

      return isAutoSignIn;
    } on SocketException {
      throw left(AppExceptions.instance.handleSocketException());
    } on MyHttpClientException catch (error) {
      ///Here --> error type: Failure
      throw left(
        AppExceptions.instance.handleMyHTTPClientException(error),
      );
    } catch (error) {
      throw left(
        AppExceptions.instance.handleException(error: error.toString()),
      );
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
