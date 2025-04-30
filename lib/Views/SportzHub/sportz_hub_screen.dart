import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SportzHubScreen extends StatelessWidget {
  const SportzHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoAppbar(
          title: "SportZHub",
          showNotificationIcon: true,
        ),
        child: NestedScrollView(
          floatHeaderSlivers: true,
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              ///Appbar
              SliverAppBar(
                toolbarHeight: 0,
                floating: true,
                snap: true,
                surfaceTintColor: AppColors.transparent,
                bottom: TabBar(
                  labelColor: AppColors.appTheme,
                  indicatorColor: AppColors.appTheme,
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
                  tabs: [
                    "My Services",
                    "My Bookings",
                  ]
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
  }
}
