import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen({
    super.key,
    required this.emailId,
    required this.password,
  });

  final String emailId;
  final String password;

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  late TextEditingController _otpController;
  String userEmailId = "";
  late AuthController _authController;
  final ValueNotifier<int> _start = ValueNotifier(0);
  Timer? _timer;

  @override
  void initState() {
    _otpController = TextEditingController();
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

  ///On Tap Resend
  void _onPressedResend() {
    _startTimer();
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
  void _verifyOtp() => _authController.onTapVerifyOtp(
        context: context,
        otp: _otpController.text.trim(),
        email: widget.emailId,
        password: widget.password,
      );

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
              Image.asset(AppImages.verifyOtp),
              OtpFieldsWidget(
                errorController: _authController.errorController,
                otpController: _otpController,
              ),
              _OtpErrorWidget(otpErrorText),
              _ResendOTPWidget(
                listenable: _start,
                onTap: _onPressedResend,
              ),
              const SizedBox(height: Sizes.spaceHeight),

              ///Verify OTP Button
              CommonButton(
                onPressed: _verifyOtp,
                text: "Verify OTP",
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
