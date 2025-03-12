import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  ///OnTap SendCode
  void _onTapSendCode(
          {required BuildContext context, required WidgetRef ref}) =>
      ref.read(authControllerPr.notifier).onTapSendCode(
            context: context,
            email: _emailController.text.trim(),
          );

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Sizes.spaceHeight * 2),
          const Text(
            "👋 Hello,",
            style: TextStyle(
              fontSize: Sizes.fontSize24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Text(
            "Welcome back to your account",
            style: TextStyle(fontSize: Sizes.fontSize18),
          ),
          const SizedBox(height: Sizes.spaceHeight),
          _EmailField(controller: _emailController),
          const SizedBox(height: Sizes.spaceHeight),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return CommonButton(
                onPressed: () => _onTapSendCode(
                  context: context,
                  ref: ref,
                ),
                text: "Send Code",
              );
            },
          ),
          const SizedBox(height: Sizes.spaceHeight),
          const HaveAnAccountWidget(authType: AuthType.login),
        ],
      ),
    );
  }
}

///Email Field
class _EmailField extends StatelessWidget {
  const _EmailField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Email",
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        validator: FieldValidators.instance.emailValidator,
        autofillHints: Formatter.instance.emailAutoFillHints,
        decoration: const InputDecoration(hintText: "Enter your email"),
      ),
    );
  }
}
