import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';

class Authorize extends StatelessWidget {
  const Authorize({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "ACCOUNT",
          style: TextStyle(
            fontSize: Sizes.fontSize18,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Login/Create Account to manage orders",
          style: TextStyle(
            fontSize: Sizes.fontSize16,
          ),
        ),
        const SizedBox(height: Sizes.space),
        CommonButton(
          onPressed: () => AppRouter.instance.push(
            context: context,
            screen: const LoginScreen(),
          ),
          text: "Login",
        ),
      ],
    );
  }
}
