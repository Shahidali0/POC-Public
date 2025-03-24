//* EmptyList Widget
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key, this.widget, this.subTitle});

  final Widget? widget;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Oh No!",
              style: TextStyle(
                color: AppColors.black,
                fontSize: Sizes.fontSize24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              subTitle ?? "Currently you don't have any data..",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: Sizes.fontSize18,
              ),
            ),
            if (widget != null) ...[
              const SizedBox(height: Sizes.space),
              widget!,
            ],
          ],
        ),
      ),
    );
  }
}
