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

class AuthRepository {
  final AuthServices _authServices;
  final LocalStorage _localStorage;

  AuthRepository({
    required AuthServices authServices,
    required LocalStorage localStorage,
  })  : _authServices = authServices,
        _localStorage = localStorage;

  ///Authenticate User
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
      bool showIntroPage = false;

      ///Get Login Details
      final signInResult = await _localStorage.getSignInResponse();

      // ///Check for authorization
      // final isAuthorized = await _localStorage.isAuthorized();
      // _ref
      //     .read(isAuthorizedPr.notifier)
      //     .update((state) => state = isAuthorized);

      ///Get Show Intro Screen Value
      final showIntro = await _localStorage.getShowIntro();
      showIntroPage = showIntro;

      ///Check if the user details are not null
      if (signInResult == null ||
          signInResult.emailId == null ||
          signInResult.password == null) return showIntroPage;

      ///Authenticate the user
      await authenticateUser(
        emailId: signInResult.emailId!,
        password: signInResult.password!,
      );

      return showIntroPage;
    } on SocketException {
      throw left(AppExceptions.instance.handleSocketException());
    } on MyHttpClientException catch (error) {
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
