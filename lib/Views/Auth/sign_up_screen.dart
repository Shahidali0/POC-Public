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
            _Tabbar(),
            _TabbarView(),
          ],
        ),
      ),
    );
  }
}

///This page shows Tabbar
class _Tabbar extends StatelessWidget {
  const _Tabbar();

  @override
  Widget build(BuildContext context) {
    debugPrint("_Tabbar");
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.only(bottom: Sizes.spaceHeightSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return TabBar(
            onTap: (value) =>
                ref.read(signUpTabIndexPr.notifier).update((st) => st = value),
            tabs: const [
              Tab(text: "Register as User"),
              Tab(text: "Register as Provider"),
            ],
          );
        },
      ),
    );
  }
}

///Tabbar view
class _TabbarView extends ConsumerWidget {
  const _TabbarView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(signUpTabIndexPr);
    debugPrint("_TabbarView");

    return Expanded(
      child: AnimatedCrossFade(
        firstChild: const UserRegistrationPage(),
        secondChild: const ProviderRegistrationPage(),
        crossFadeState:
            index == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: Sizes.durationL,
      ),
    );
  }
}
