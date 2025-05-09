import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen({
    super.key,
    required this.emailId,
    required this.password,
    this.verificationType = OtpVerificationType.signup,
  });

  final String emailId;
  final String password;
  final OtpVerificationType verificationType;

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  late TextEditingController _otpController;
  late TextEditingController _passwordController;

  late AuthController _authController;
  final ValueNotifier<int> _start = ValueNotifier(0);
  final ValueNotifier<bool> _hidePassword = ValueNotifier(true);

  Timer? _timer;
  String userEmailId = "";

  @override
  void initState() {
    _otpController = TextEditingController();
    _passwordController = TextEditingController();
    _authController = ref.read(authControllerPr.notifier);

    ///Init error controller for OTP field
    _authController.init();

    ///Now get the hidden Email
    userEmailId = _authController.hideEmail(widget.emailId);

    ///Start timer for Showing [Resend OTP] button
    _startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _authController.disposeM();
    _timer?.cancel();
    super.dispose();
  }

  ///Timer For Resend OTP button
  void _startTimer() {
    _start.value = 60;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_start.value == 0) {
          timer.cancel();
        } else {
          _start.value--;
        }
      },
    );
  }

  ///Hide Password
  void _hidePasswordFunction() {
    _hidePassword.value = !_hidePassword.value;
  }

  ///On Tap Resend
  void _onPressedResend() {
    _startTimer();

    showSuccessSnackBar(
      context: context,
      content: "Feature coming soon",
    );
    // ref.read(authControllerPr).sendOtp(
    //       context: context,
    //       emailId: widget.emailId,
    //       isResendOtp: true,
    //     );

    ///Clear previous data
    _otpController.clear();
    _authController.otpErrorText = ValueNotifier("");
  }

  ///Verify OTP
  void _verifyOtp() {
    ///Otp verification for -- Signup
    if (widget.verificationType == OtpVerificationType.signup) {
      _authController.onSignUpOtpVerification(
        context: context,
        otp: _otpController.text.trim(),
        email: widget.emailId,
        password: widget.password,
      );
      return;
    }

    ///Forgot Password Otp verification
    _authController.confirmForgotPasswordOtpVerification(
      context: context,
      otp: _otpController.text.trim(),
      email: widget.emailId,
      newPassword: _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var otpErrorText = ref.watch(authControllerPr.notifier).otpErrorText;
    final isLoading = ref.watch(authControllerPr);

    return AuthBackground(
      title: "Verify with OTP",
      child: AbsorbPointer(
        absorbing: isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "We have sent you a security code to\n $userEmailId \n Please type it here",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: Sizes.fontSize18),
              ),

              ///Image
              Image.asset(AppImages.verifyOtp),

              ///Otp Fields
              OtpFieldsWidget(
                errorController: _authController.errorController,
                otpController: _otpController,
              ),
              _OtpErrorWidget(otpErrorText),

              ///Resend OTP
              _ResendOTPWidget(
                listenable: _start,
                onTap: _onPressedResend,
              ),

              ///For ForgotPassword Otp Verification
              if (widget.verificationType == OtpVerificationType.forgotPassword)
                _NewPasswordField(
                  controller: _passwordController,
                  hidePassword: _hidePassword,
                  hidePasswordFunction: _hidePasswordFunction,
                ),
              const SizedBox(height: Sizes.spaceHeight * 1.5),

              ///Verify OTP Button
              CommonButton(
                onPressed: _verifyOtp,
                text: widget.verificationType == OtpVerificationType.signup
                    ? "Verify OTP"
                    : "Reset Password",
                isLoading: isLoading,
              ),
              const SizedBox(height: Sizes.spaceHeight),
            ],
          ),
        ),
      ),
    );
  }
}

///OTP Error Widget
class _OtpErrorWidget extends ConsumerWidget {
  const _OtpErrorWidget(this.otpErrorText);

  final ValueListenable<String> otpErrorText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: otpErrorText,
      builder: (BuildContext context, String value, Widget? child) {
        return value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.red,
                    fontSize: Sizes.fontSize16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}

///Resend OTP Widget
class _ResendOTPWidget extends StatelessWidget {
  const _ResendOTPWidget({required this.listenable, required this.onTap});

  final ValueListenable<int> listenable;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenable,
      builder: (BuildContext context, int listeningValue, Widget? child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///Resend Widget
            Flexible(
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Didn’t get the code?  ",
                      style: TextStyle(
                        fontSize: Sizes.defaultSize,
                        color: AppColors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Resend it",
                      style: TextStyle(
                        fontSize: Sizes.defaultSize,
                        fontWeight: FontWeight.w700,
                        color: listeningValue != 0
                            ? Theme.of(context).disabledColor
                            : AppColors.orange,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                      recognizer: listeningValue == 0
                          ? (TapGestureRecognizer()..onTap = onTap)
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Sizes.spaceMed),

            ///Timer
            if (listeningValue != 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "( Try again in ",
                    style: TextStyle(
                      fontSize: Sizes.defaultSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      listeningValue.toString(),
                      key: Key(listeningValue.toString()),
                      style: const TextStyle(
                        fontSize: Sizes.fontSize18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Text(
                    " Seconds )",
                    style: TextStyle(
                      fontSize: Sizes.defaultSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

///New Password Field
class _NewPasswordField extends StatelessWidget {
  const _NewPasswordField({
    required this.controller,
    required this.hidePassword,
    required this.hidePasswordFunction,
  });

  final TextEditingController controller;
  final ValueNotifier hidePassword;
  final VoidCallback? hidePasswordFunction;

  @override
  Widget build(BuildContext context) {
    return FadeAnimations(
      child: FormFiledWidget(
        title: "New Password",
        isRequired: true,
        child: ValueListenableBuilder(
          valueListenable: hidePassword,
          builder: (BuildContext context, value, Widget? child) {
            return TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              obscureText: value,
              validator: FieldValidators.instance.passwordValidator,
              decoration: InputDecoration(
                hintText: "Enter a new password",
                suffixIcon: IconButton(
                  onPressed: hidePasswordFunction,
                  icon: Icon(
                    value
                        ? CupertinoIcons.eye_slash_fill
                        : CupertinoIcons.eye_fill,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
