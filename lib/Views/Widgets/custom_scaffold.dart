import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///CupertinoStyle Scaffold with [Nested Scrollview and Sliver type appbar]
class MyCupertinoSliverScaffold extends StatelessWidget {
  const MyCupertinoSliverScaffold({
    super.key,
    this.title,
    required this.body,
    this.previousPageTitle,
    this.trailing,
    this.bottomNavBar,
    this.scrollController,
    this.margin = const EdgeInsets.only(
      left: Sizes.space,
      right: Sizes.space,
      top: Sizes.space,
    ),
  });

  final String? title;
  final Widget body;
  final String? previousPageTitle;
  final Widget? trailing;
  final Widget? bottomNavBar;
  final ScrollController? scrollController;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        controller: scrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          CupertinoSliverNavigationBar(
            key: GlobalKey(),
            backgroundColor: AppColors.transparent,
            border: Border(bottom: BorderSide(color: AppColors.lightGrey)),
            previousPageTitle: previousPageTitle ?? "Back",
            trailing: trailing,
            alwaysShowMiddle: false,
            automaticallyImplyTitle: false,
            transitionBetweenRoutes: false,
            middle: title == null
                ? null
                : Text(
                    title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: AppColors.appTheme,
                    ),
                  ),
            largeTitle: title == null
                ? null
                : Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: AppColors.black,
                      fontSize: Sizes.fontSize24,
                    ),
                  ),
          ),
        ],
        body: Scaffold(
          bottomNavigationBar: bottomNavBar,
          body: SafeArea(
            top: false,
            minimum: margin,
            child: body,
          ),
        ),
      ),
    );
  }
}

// ///CupertinoStyle Scaffold with [Nested Scrollview and Sliver type appbar]
// class MyCupertinoScaffold extends StatelessWidget {
//   const MyCupertinoScaffold({
//     super.key,
//     required this.title,
//     required this.body,
//     this.previousPageTitle,
//     this.trailing,
//     this.bottomNavBar,
//     this.scrollController,
//     this.margin = const EdgeInsets.only(
//       left: Sizes.space,
//       right: Sizes.space,
//       top: Sizes.space,
//     ),
//   });

//   final String title;
//   final Widget body;
//   final String? previousPageTitle;
//   final Widget? trailing;
//   final Widget? bottomNavBar;
//   final ScrollController? scrollController;
//   final EdgeInsets margin;

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         backgroundColor: AppColors.transparent,
//         border: const Border(
//           bottom: BorderSide(color: AppColors.blueGrey, width: 0.1),
//         ),
//         previousPageTitle: previousPageTitle ?? "Back",
//         trailing: trailing ??
//             CommonIconButton(
//               onPressed: () => AppRouter.instance.push(
//                 context: context,
//                 screen: const NotificationScreen(),
//               ),
//               iconData: CupertinoIcons.bell,
//             ),
//         // transitionBetweenRoutes: false,
//         middle: Text(
//           title,
//           style: const TextStyle(
//             color: AppColors.appTheme,
//             fontSize: Sizes.fontSize18,
//           ),
//         ),
//       ),
//       child: body,
//     );
//   }
// }
