import 'dart:async';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

final authControllerPr = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.read(authRepositoryPr),
    ref: ref,
  ),
);

final signUpTabIndexPr = StateProvider<int>((ref) => 0);

final obSecurePasswordPr = StateProvider<bool>((ref) => true);

final signupGoalErrorPr = StateProvider<String>((ref) => "");
final signupAbouYouSelfErrorPr = StateProvider<String>((ref) => "");

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
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

  ///Update Error Valuefor MainGoal
  void _updateErrorForMainGoal(String value) =>
      _ref.read(signupGoalErrorPr.notifier).update((st) => st = value);

  ///Update Error Value for About yourSelf
  void _updateErrorForAboutYourSelf(String value) =>
      _ref.read(signupAbouYouSelfErrorPr.notifier).update((st) => st = value);

  //################################### ############################
  //################################### ############################

  /*
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
  */

  ///Sign in User
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      showErrorSnackBar(
        context: context,
        content: "Required Email-Id and Password",
      );
      return;
    }

    state = true;

    final isSignedIn = await _authRepository.authenticateUser(
      emailId: email,
      password: password,
    );

    state = false;

    isSignedIn.fold(
      (failure) => showErrorSnackBar(
        context: context,
        title: failure.title,
        content: failure.message,
      ),
      (success) => AppRouter.instance.pushOff(
        context: context,
        screen: const DashboardNavbarScreen(),
      ),
    );
  }

  ///Sign Up User
  Future<void> signUpUser({
    required BuildContext context,
    required SignUpDto signUpDto,
    required GlobalKey<FormState> formKey,
  }) async {
    final validate = validateForm(formKey);
    final isGoalEmpty = signUpDto.goal == null;
    final isUserEmpty = signUpDto.userType == null;

    ///Update Error for MainGoal-- if[isGoalEmpty]
    _updateErrorForMainGoal(
      isGoalEmpty ? "Please provide your Main Goal" : "",
    );

    ///Update Error for AboutYourSelf if[isUserEmpty]
    _updateErrorForAboutYourSelf(
      isUserEmpty ? "Please tell us about your self" : "",
    );

    if (!validate || isGoalEmpty || isUserEmpty) {
      showErrorSnackBar(
        context: context,
        content: AppExceptions.instance.requiredYourInput,
      );
      return;
    }

    state = true;

    final isSignedIn = await _authRepository.signUpUser(dto: signUpDto);

    state = false;

    isSignedIn.fold(
      (failure) => showErrorSnackBar(
        context: context,
        title: failure.title,
        content: failure.message,
      ),
      (success) {
        showSuccessSnackBar(
          context: context,
          content: success,
        );
        return AppRouter.instance.pushReplacement(
          context: context,
          screen: OtpVerificationScreen(
            emailId: signUpDto.username!,
          ),
        );
      },
    );
  }

  ///Ontap Verify OTP
  void onTapVerifyOtp({
    required BuildContext context,
    required String email,
    required String otp,
  }) async {
    ///Clear error if any
    otpErrorText = ValueNotifier("");

    Utils.instance.hideFoucs(context);

    if (otp.isEmpty) {
      errorController?.add(ErrorAnimationType.shake);
      otpErrorText = ValueNotifier("Required OTP");

      return;
    }

    state = true;

    final isOtpVerified = await _authRepository.verifyOtpAndSignIn(
      otp: otp,
      email: email,
    );

    state = false;

    isOtpVerified.fold(
      (failure) {
        errorController?.add(ErrorAnimationType.shake);
        otpErrorText = ValueNotifier(failure.message);

        showErrorSnackBar(
          context: context,
          title: failure.title,
          content: failure.message,
        );
      },
      (success) {
        showSuccessSnackBar(
          context: context,
          content: success,
        );

        ///Goto Dashboard
        return AppRouter.instance.pushOff(
          context: context,
          screen: const DashboardNavbarScreen(),
        );
      },
    );
  }
}
