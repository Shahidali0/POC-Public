import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class IntroFinalScreen extends ConsumerWidget {
  const IntroFinalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: Sizes.globalMargin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///Close Button
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => AppRouter.instance.pop(context),
              child: const Icon(Icons.close),
            ),
          ),

          ///Header
          const Text(
            "Ready to Get Started?",
            style: TextStyle(
              fontSize: Sizes.fontSize20,
              fontWeight: FontWeight.w800,
              color: AppColors.appTheme,
            ),
          ),
          const SizedBox(height: Sizes.spaceHeightSm),
          const Text(
            "Whether you're looking to improve your game skills, organize a match, or rent equipment, we've got you covered with the best service providers in your area.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Sizes.defaultSize,
              fontWeight: FontWeight.normal,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: Sizes.spaceHeight),

          ///Find Services Button
          CommonOutlineButton(
            onPressed: () => ref
                .read(introControllerPr.notifier)
                .onTapFindServices(context: context),
            text: "Find services",
          ),
          const SizedBox(height: Sizes.space),

          ///Become a provider Button
          CommonButton(
            onPressed: () => ref
                .read(introControllerPr.notifier)
                .onTapBecomeProvider(context: context),
            text: "Become a provider",
          ),
          const SizedBox(height: Sizes.spaceHeight),
        ],
      ),
    );
  }
}
