import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyServicesScreen extends StatefulWidget {
  const MyServicesScreen({super.key});

  @override
  State<MyServicesScreen> createState() => _FindServicesScreenState();
}

class _FindServicesScreenState extends State<MyServicesScreen> {
  ///OnTap Filter Icon
  Future _onTapFilter() async => AppRouter.instance.animatedPush(
        context: context,
        type: FadeAnimationType.upDown,
        screen: const ServiceFilters(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: myServicesTabs.length,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                ///Appbar
                MyDashboardAppbar(
                  bottomTitle: "Provider Dashboard",
                  bottomSubTitle:
                      "John Smith - Former state player with 10 years of coaching experience",
                  appBarColor: AppColors.indicatorColors[2],
                  actions: [
                    CommonCircleButton(
                      backgroundColor: AppColors.indicatorColors[2],
                      iconColor: AppColors.white,
                      onPressed: _onTapFilter,
                      iconData: CupertinoIcons.slider_horizontal_3,
                    ),
                  ],
                ),

                ///Tabs
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverPinnedTabBar(
                    tabList: myServicesTabs,
                    isScrollable: false,
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
      ),
    );
  }
}
