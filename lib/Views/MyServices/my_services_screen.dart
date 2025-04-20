import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyServicesScreen extends StatelessWidget {
  const MyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoAppbar(
          title: "My Services",
          showNotificationIcon: true,
        ),
        child: AuthorizedWidget(
          child: NestedScrollView(
            floatHeaderSlivers: true,
            physics: const ClampingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                ///Appbar
                SliverAppBar(
                  toolbarHeight: 0,
                  bottom: TabBar(
                    labelColor: AppColors.appTheme,
                    indicatorColor: AppColors.appTheme,
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.space),
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
      ),
    );
  }
}
