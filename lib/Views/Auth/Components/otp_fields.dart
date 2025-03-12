import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/services.dart';

///Otp Fields Widget
class OtpFieldsWidget extends StatelessWidget {
  const OtpFieldsWidget({
    super.key,
    required this.errorController,
    required TextEditingController otpController,
  }) : _otpController = otpController;

  final StreamController<ErrorAnimationType>? errorController;

  final TextEditingController _otpController;

  @override
  Widget build(BuildContext context) {
    debugPrint("OtpFieldsWidget");
    return PinCodeTextField(
      autoDisposeControllers: false,
      // autoFocus: true,
      appContext: context,
      mainAxisAlignment: MainAxisAlignment.center,
      backgroundColor: AppColors.transparent,
      pastedTextStyle: const TextStyle(
        color: AppColors.appTheme,
        fontWeight: FontWeight.bold,
      ),
      textStyle: const TextStyle(
        color: AppColors.appTheme,
        fontWeight: FontWeight.bold,
      ),
      length: 4,
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: null,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        borderWidth: 0.2,
        fieldHeight: 55,
        fieldWidth: 55,
        fieldOuterPadding: const EdgeInsets.only(right: Sizes.space),
        activeFillColor: AppColors.transparent,
        activeColor: AppColors.appTheme,
        inactiveFillColor: AppColors.transparent,
        inactiveColor: AppColors.blueGrey,
        selectedColor: AppColors.appTheme,
        selectedFillColor: AppColors.appTheme.withOpacity(0.2),
        inactiveBorderWidth: 1,
      ),
      cursorColor: AppColors.white,
      cursorHeight: 14,
      animationDuration: const Duration(milliseconds: 500),
      enableActiveFill: true,
      errorAnimationController: errorController,
      controller: _otpController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      boxShadows: const [
        BoxShadow(
          offset: Offset(0, 2),
          color: AppColors.blueGrey,
          blurRadius: 4,
        )
      ],
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        return true;
      },
    );
  }
}
