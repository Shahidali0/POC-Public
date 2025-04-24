import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

final introControllerPr = StateNotifierProvider<IntroController, bool>(
  (ref) => IntroController(
    localStorage: LocalStorage(),
  ),
);

final introIndexPr = StateProvider<int>((ref) => 0);

class IntroController extends StateNotifier<bool> {
  final LocalStorage _localStorage;
  IntroController({required LocalStorage localStorage})
      : _localStorage = localStorage,
        super(false);

  ///Show Dailog for ReadyToGetStarted
  FutureVoid _showDialogBoxForMarkReady(BuildContext context) {
    return LogHelper.instance.showGeneralDialogBox(
      context: context,
      barrierLabel: "Ready To Get Started",
      child: const IntroFinalScreen(),
    );
  }

  ///OnTap Skip Button
  void onTapSkip({
    required BuildContext context,
  }) async =>
      await _showDialogBoxForMarkReady(context);

  ///OnTap Next Button
  void onTapNext({
    required BuildContext context,
    required PageController pageController,
    required int currentIndex,
  }) async {
    ///It its last index then show the popup
    if (currentIndex == 2) {
      await _showDialogBoxForMarkReady(context);
      return;
    }

    ///Else show other pages
    pageController.nextPage(
      duration: Sizes.duration,
      curve: Sizes.curve,
    );
  }

  ///OnTap Find Services
  Future? onTapFindServices({
    required BuildContext context,
  }) async {
    AppRouter.instance.pop(context);

    ///Set Show Intro to false
    await _localStorage.setShowIntro(showIntro: false);

    if (!context.mounted) return;

    return AppRouter.instance.pushOff(
      context: context,
      page: const DashboardScreen(),
    );
  }

  ///OnTap Become a provider
  Future? onTapBecomeProvider({
    required BuildContext context,
  }) async {
    AppRouter.instance.pop(context);

    ///Set Show Intro to false
    await _localStorage.setShowIntro(showIntro: false);

    if (!context.mounted) return;

    AppRouter.instance.pushOff(
      context: context,
      page: const DashboardScreen(),
    );

    return AppRouter.instance.push(
      context: context,
      page: const SignUpScreen(),
    );
  }
}
