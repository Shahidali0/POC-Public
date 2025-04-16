import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ///This is a sliver app bar
// class MyDashboardSliverAppbar extends StatelessWidget {
//   const MyDashboardSliverAppbar({
//     super.key,
//     this.bottomTitle,
//     this.bottomSubTitle,
//     this.actions,
//     this.pinned = false,
//     this.floating = true,
//   });

//   final String? bottomTitle;
//   final String? bottomSubTitle;
//   final List<Widget>? actions;

//   final bool pinned;
//   final bool floating;

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       pinned: pinned,
//       floating: floating,
//       snap: floating,
//       scrolledUnderElevation: 0,
//       surfaceTintColor: AppColors.white,

//       centerTitle: false,
//       toolbarHeight: bottomTitle == null && bottomSubTitle == null
//           ? kToolbarHeight
//           : kToolbarHeight * 1.5,
//       titleSpacing: Sizes.space,
//       title: const FadeAnimations(
//         child: Text(
//           "Game Connect",
//           style: TextStyle(fontSize: Sizes.fontSize20),
//         ),
//       ),

//       bottom: bottomTitle == null && bottomSubTitle == null
//           ? null
//           : PreferredSize(
//               preferredSize: const Size.fromHeight(kToolbarHeight),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       bottomTitle ?? "",
//                       style: const TextStyle(
//                         fontSize: Sizes.fontSize20,
//                         fontWeight: FontWeight.w800,
//                         color: AppColors.appTheme,
//                       ),
//                     ),
//                     Text(bottomSubTitle ?? ''),
//                     const SizedBox(height: Sizes.spaceHeight),
//                   ],
//                 ),
//               ),
//             ),

//       actions: [
//         ...?actions,

//         ///Notification Button
//         FadeAnimations(
//           child: CommonIconButton(
//             onPressed: () => AppRouter.instance.push(
//               context: context,
//               screen: const NotificationScreen(),
//             ),
//             iconData: CupertinoIcons.bell,
//           ),
//         ),
//       ],

//       // flexibleSpace: DecoratedBox(
//       //   decoration: BoxDecoration(
//       //     gradient: LinearGradient(
//       //       begin: Alignment.topCenter,
//       //       end: Alignment.bottomCenter,
//       //       colors: [
//       //         surfaceTintColor,
//       //         surfaceTintColor.withOpacity(0.6),
//       //         AppColors.white,
//       //       ],
//       //     ),
//       //   ),
//       //   child: const FlexibleSpaceBar(collapseMode: CollapseMode.parallax),
//       // ),
//     );
//   }
// }

// ///Custom Tabbar--pinned
// class SliverPinnedTabBar extends SliverPersistentHeaderDelegate {
//   const SliverPinnedTabBar({
//     required this.tabList,
//     this.isScrollable = true,
//     this.backgorundColor = AppColors.white,
//   });

//   final List tabList;
//   final bool isScrollable;
//   final Color backgorundColor;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return ColoredBox(
//       color: backgorundColor,
//       child: TabBar(
//         dividerColor: AppColors.border,
//         isScrollable: isScrollable,
//         tabAlignment: isScrollable ? TabAlignment.start : null,
//         padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
//         labelPadding: isScrollable
//             ? const EdgeInsets.symmetric(horizontal: Sizes.spaceHeight)
//             : null,
//         tabs: tabList
//             .map(
//               (text) => Tab(text: text),
//             )
//             .toList(),
//       ),
//     );
//   }

//   @override
//   double get maxExtent => kTextTabBarHeight;

//   @override
//   double get minExtent => kTextTabBarHeight;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       false;
// }

///Normal Page Appbar
class CupertinoAppbar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const CupertinoAppbar({
    super.key,
    required this.title,
    this.previousPageTitle,
    this.trailing,
    this.showNotificationIcon = false,
  });

  final String title;
  final String? previousPageTitle;
  final Widget? trailing;

  final bool showNotificationIcon;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      transitionBetweenRoutes: false,
      backgroundColor: AppColors.transparent,
      border: const Border(
        bottom: BorderSide(color: AppColors.blueGrey, width: 0.1),
      ),
      previousPageTitle: previousPageTitle ?? "Back",
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) trailing!,
          if (showNotificationIcon)
            CommonIconButton(
              onPressed: () => AppRouter.instance.push(
                context: context,
                screen: const NotificationScreen(),
              ),
              iconData: CupertinoIcons.bell,
            ),
        ],
      ),
      middle: Text(
        title,
        style: const TextStyle(
          color: AppColors.appTheme,
          fontSize: Sizes.fontSize18,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  bool shouldFullyObstruct(BuildContext context) => false;
}
