import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDashboardAppbar extends StatelessWidget {
  const MyDashboardAppbar({
    super.key,
    this.bottomTitle,
    this.bottomSubTitle,
    this.actions,
    required this.appBarColor,
    this.pinned = false,
    this.floating = true,
  });

  final String? bottomTitle;
  final String? bottomSubTitle;
  final List<Widget>? actions;
  final Color appBarColor;
  final bool pinned;
  final bool floating;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: pinned,
      floating: floating,
      snap: floating,
      scrolledUnderElevation: 0,
      surfaceTintColor: AppColors.white,
      shadowColor: appBarColor.withOpacity(0.3),
      centerTitle: false,
      toolbarHeight: bottomTitle == null && bottomSubTitle == null
          ? kToolbarHeight
          : kToolbarHeight * 1.5,
      titleSpacing: Sizes.space,
      title: FadeAnimations(
        child: Text(
          "PlayMate",
          style: TextStyle(
            fontSize: Sizes.fontSize20,
            color: appBarColor,
          ),
        ),
      ),

      bottom: bottomTitle == null && bottomSubTitle == null
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bottomTitle ?? "",
                      style: const TextStyle(
                        fontSize: Sizes.fontSize20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.appTheme,
                      ),
                    ),
                    Text(bottomSubTitle ?? ''),
                    const SizedBox(height: Sizes.spaceHeight),
                  ],
                ),
              ),
            ),

      actions: [
        ...?actions,

        ///Notification Button
        FadeAnimations(
          child: CommonCircleButton(
            onPressed: () => AppRouter.instance.push(
              context: context,
              screen: const NotificationScreen(),
            ),
            iconData: CupertinoIcons.bell,
            iconColor: AppColors.white,
            backgroundColor: appBarColor,
          ),
        ),
      ],

      // flexibleSpace: DecoratedBox(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       colors: [
      //         surfaceTintColor,
      //         surfaceTintColor.withOpacity(0.6),
      //         AppColors.white,
      //       ],
      //     ),
      //   ),
      //   child: const FlexibleSpaceBar(collapseMode: CollapseMode.parallax),
      // ),
    );
  }
}

///Custom Tabbar--pinned
class SliverPinnedTabBar extends SliverPersistentHeaderDelegate {
  const SliverPinnedTabBar({
    required this.tabList,
    this.isScrollable = true,
    this.backgorundColor = AppColors.white,
  });

  final List tabList;
  final bool isScrollable;
  final Color backgorundColor;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: backgorundColor,
      child: TabBar(
        dividerColor: AppColors.border,
        isScrollable: isScrollable,
        tabAlignment: isScrollable ? TabAlignment.start : null,
        padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
        labelPadding: isScrollable
            ? const EdgeInsets.symmetric(horizontal: Sizes.space)
            : null,
        tabs: tabList
            .map(
              (text) => Tab(text: text),
            )
            .toList(),
      ),
    );
  }

  @override
  double get maxExtent => kTextTabBarHeight;

  @override
  double get minExtent => kTextTabBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

// ///Normal Page Sliver Appbar
// class NormalSliverAppbar extends StatelessWidget {
//   const NormalSliverAppbar({
//     super.key,
//     required this.title,
//     this.actions,
//   });
//   final String title;
//   final List<Widget>? actions;

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar.medium(
//       floating: true,
//       snap: true,
//       scrolledUnderElevation: 4,
//       title: Text(title),
//       actions: actions,
//     );
//   }
// }

///CupertinoStyle Tabbar
class MyCupertinoPageScaffold extends StatelessWidget {
  const MyCupertinoPageScaffold({
    super.key,
    required this.title,
    required this.body,
    this.previousPageTitle,
    this.trailing,
    this.bottomNavBar,
    this.margin = Sizes.globalMargin,
  });

  final String title;
  final Widget body;
  final String? previousPageTitle;
  final Widget? trailing;
  final Widget? bottomNavBar;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          CupertinoSliverNavigationBar(
            backgroundColor:
                AppColors.transparent, // Makes the AppBar transparent
            // border: null,
            border: Border(bottom: BorderSide(color: AppColors.lightGrey)),
            previousPageTitle: previousPageTitle,
            trailing: trailing,
            alwaysShowMiddle: false,
            middle: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: AppColors.appTheme,
              ),
            ),
            largeTitle: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: AppColors.black,
                fontSize: Sizes.fontSize22,
              ),
            ),
          ),
        ],
        body: Scaffold(
          bottomNavigationBar: bottomNavBar,
          body: Padding(
            padding: margin,
            child: body,
          ),
        ),
      ),
    );
  }
}
