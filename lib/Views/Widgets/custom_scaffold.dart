import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///CupertinoStyle Scaffold with [Nested Scrollview and Sliver type appbar]
class MyCupertinoSliverScaffold extends StatelessWidget {
  const MyCupertinoSliverScaffold({
    super.key,
    required this.title,
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

  final String title;
  final Widget body;
  final String? previousPageTitle;
  final Widget? trailing;
  final Widget? bottomNavBar;
  final ScrollController? scrollController;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      body: CupertinoPageScaffold(
        child: NestedScrollView(
          controller: scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            MyCupertinoSliverAppbar(
              previousPageTitle: previousPageTitle,
              trailing: trailing,
              title: title,
            ),
          ],
          body: Padding(
            padding: margin,
            child: body,
          ),
        ),
      ),
    );
  }
}

///CupertinoStyle Sliver Appbar
class MyCupertinoSliverAppbar extends StatelessWidget {
  const MyCupertinoSliverAppbar({
    super.key,
    this.previousPageTitle,
    this.trailing,
    required this.title,
  });

  final String? previousPageTitle;
  final Widget? trailing;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      backgroundColor: AppColors.transparent,
      border: Border(bottom: BorderSide(color: AppColors.lightGrey)),
      previousPageTitle: previousPageTitle ?? "Back",
      trailing: trailing,
      alwaysShowMiddle: false,
      middle: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.appTheme,
          fontFamily: AppTheme.boldFont,
        ),
      ),
      largeTitle: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          fontSize: Sizes.fontSize24,
          fontFamily: AppTheme.boldFont,
        ),
      ),
    );
  }
}
