import 'dart:async';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

final authControllerPr = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.read(authRepositoryPr),
  ),
);

final signUpTabIndexPr = StateProvider<int>((ref) => 0);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(false);

  late StreamController<ErrorAnimationType>? errorController;
  late ValueNotifier<String> otpErrorText;

  ///Call init in OTP Screen
  void init() {
    otpErrorText = ValueNotifier("");
    errorController = StreamController<ErrorAnimationType>();
  }

  ///Dispose in OTP Screen
  void disposeM() {
    errorController?.close();
  }

  ///Hide EmailId  Function
  String hideEmail(String emailId) {
    var hiddenEmail = "";
    for (int i = 0; i < emailId.length; i++) {
      if (i >= 2 && i < emailId.indexOf("@")) {
        hiddenEmail += "*";
      } else {
        hiddenEmail += emailId[i];
      }
    }
    return hiddenEmail;
  }

  //################################### ############################
  //################################### ############################

  ///Ontap Register as User
  void onTapRegisterAsUser({
    required BuildContext context,
    required UserRegistrationDto userData,
  }) {
    ///Not validated
    if (!userData.isValidated) {
      showErrorSnackBar(
        context: context,
        content: FieldValidators.instance.requiredText,
      );
      return;
    }

    ///Else
    showSuccessSnackBar(
      context: context,
      content: "User registered successfully",
    );
  }

  ///Ontap Register as Provider
  void onTapRegisterAsProvider({
    required BuildContext context,
    required ProviderRegistrationDto providerData,
  }) {
    ///Not validated
    if (!providerData.isValidated) {
      showErrorSnackBar(
        context: context,
        content: FieldValidators.instance.requiredText,
      );
      return;
    }

    ///Else
    showSuccessSnackBar(
      context: context,
      content: "Provider registration was successfull",
    );
  }

  ///Ontap SendCode For Login
  void onTapSendCode({
    required BuildContext context,
    required String email,
  }) async {
    ///Email is Empty
    if (email.isEmpty) {
      showErrorSnackBar(
        context: context,
        content: FieldValidators.instance.requiredText,
      );
      return;
    }

    ///Else
    showSuccessSnackBar(
      context: context,
      content: "Provider registration was successfull",
    );

    AppRouter.instance.push(
      context: context,
      screen: OtpVerificationScreen(emailId: email),
    );
  }

  ///Ontap Verify OTP
  void onTapVerifyOtp({
    required BuildContext context,
    required String email,
    required String otp,
  }) {}
}
