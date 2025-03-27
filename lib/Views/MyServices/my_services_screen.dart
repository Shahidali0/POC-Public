import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyServicesScreen extends StatelessWidget {
  const MyServicesScreen({super.key});

  // ///OnTap Filter Icon
  // Future _onTapFilter(BuildContext context) async =>
  //     AppRouter.instance.animatedPush(
  //       context: context,
  //       type: MyAnimationType.upDown,
  //       screen: const ServiceFilters(),
  //     );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoAppbar(
          title: "My Services",
          showNotificationIcon: true,
        ),
        child: NestedScrollView(
          floatHeaderSlivers: true,
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              ///Appbar
              SliverAppBar(
                floating: true,
                scrolledUnderElevation: 0,
                surfaceTintColor: AppColors.white,
                titleSpacing: Sizes.space,
                foregroundColor: AppColors.black,
                title: const Text(
                  "John Smith - Former state player with 10 years of coaching experience\n",
                  maxLines: 3,
                  style: TextStyle(
                    color: AppColors.blueGrey,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                bottom: TabBar(
                  labelColor: AppColors.appTheme,
                  indicatorColor: AppColors.appTheme,
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
                  tabs: myServicesTabsData
                      .map(
                        (text) => Tab(text: text),
                      )
                      .toList(),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              MyServicesTabview(),
              MyBookingsTabview(),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   body: SafeArea(
    //     child: DefaultTabController(
    //       length: myServicesTabs.length,
    //       child: NestedScrollView(
    // headerSliverBuilder:
    //     (BuildContext context, bool innerBoxIsScrolled) {
    //   return [
    //     ///Appbar
    //     MyDashboardSliverAppbar(
    //       bottomTitle: "Provider Dashboard",
    //       bottomSubTitle:
    //           "John Smith - Former state player with 10 years of coaching experience",
    //       actions: [
    //         CommonIconButton(
    //           onPressed: () => _onTapFilter(context),
    //           iconData: CupertinoIcons.slider_horizontal_3,
    //         ),
    //       ],
    //     ),
    //     ///Tabs
    //     SliverPersistentHeader(
    //       pinned: true,
    //       delegate: SliverPinnedTabBar(
    //         tabList: myServicesTabs,
    //         isScrollable: false,
    //       ),
    //     ),
    //   ];
    // },
    // body: const TabBarView(
    //   children: [
    //     MyServicesTabview(),
    //     MyBookingsTabview(),
    //   ],
    // ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
