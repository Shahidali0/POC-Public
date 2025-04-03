import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.title,
    required this.error,
    this.onRefresh,
  });

  final String error;
  final String? title;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? AppExceptions.instance.normalErrorText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: Sizes.fontSize24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Sizes.spaceMed),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: Sizes.fontSize20,
              fontWeight: FontWeight.normal,
            ),
          ),
          if (onRefresh != null) ...[
            const SizedBox(height: Sizes.space),
            CommonButton(onPressed: onRefresh, text: "Refresh"),
          ],
        ],
      ),
    );
  }
}
