import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({super.key, required this.authType});

  final AuthType authType;

  ///OnTap Functionality
  Future _onTap(BuildContext context) async {
    if (authType == AuthType.signup) {
      return AppRouter.instance.pop(context);
    }
    return AppRouter.instance.push(
      context: context,
      screen: const SignUpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String title = authType == AuthType.signup
        ? "Already have an account? "
        : "Not registered yet? ";

    final String buttonText =
        authType == AuthType.signup ? "Login" : "Create Account";
    return Align(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: title,
          style: const TextStyle(
            color: AppColors.blueGrey,
            fontSize: Sizes.defaultSize,
          ),
          children: [
            TextSpan(
              text: buttonText,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                color: AppColors.appTheme,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()..onTap = () => _onTap(context),
            ),
          ],
        ),
      ),
    );
  }
}
