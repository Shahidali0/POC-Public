import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("MAIN BUILD");
    return const AuthBackground(
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Sizes.spaceHeight),
            Text(
              "Hello,",
              style: TextStyle(
                fontSize: Sizes.fontSize24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              "Get started with PlayMate",
              style: TextStyle(
                fontSize: Sizes.fontSize18,
              ),
            ),
            SizedBox(height: Sizes.spaceHeightSm),
          ],
        ),
      ),
    );
  }
}
