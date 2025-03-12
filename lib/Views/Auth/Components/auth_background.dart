import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child, this.title});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final screenSize = Sizes.screenSize(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: title != null
          ? AppBar(
              centerTitle: true,
              backgroundColor: AppColors.transparent,
              title: Text(title!),
            )
          : null,
      body: Stack(
        children: [
          ///Gradient 1
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenSize.height * 0.25,
              decoration: const BoxDecoration(
                gradient: AppColors.authGradient1,
              ),
            ),
          ),

          ///Gradient 2
          Positioned.fill(
            top: screenSize.height * 0.25,
            left: 0,
            right: 0,
            child: Container(
              height: screenSize.height * 0.75,
              decoration: const BoxDecoration(
                gradient: AppColors.authGradient2,
              ),
            ),
          ),

          ///Show Child
          Positioned.fill(
            child: SafeArea(
              minimum: Sizes.globalMargin,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
