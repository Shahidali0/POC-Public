import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindServicesScreen extends StatefulWidget {
  const FindServicesScreen({super.key});

  @override
  State<FindServicesScreen> createState() => _FindServicesScreenState();
}

class _FindServicesScreenState extends State<FindServicesScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoAppbar(title: "Find Services"),
      child: ListView.separated(
        padding: Sizes.cupertinoScaffoldPadding(context),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: const CardWidget(),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: Sizes.space),
      ),
    );
  }
}


// DefaultTabController(
//         length: findServicesTabs.length,
//         child: NestedScrollView(
//           controller: _scrollController,
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return [
//               ///Appbar
//               const MyDashboardAppbar(
//                 bottomTitle: "GameSkill Connect",
//                 bottomSubTitle:
//                     "Compare and choose from multiple service providers in your area",
//                 appBarColor: AppColors.appTheme,
//               ),

//               ///Tabs
//               SliverPersistentHeader(
//                 pinned: true,
//                 delegate: SliverPinnedTabBar(
//                   tabList: findServicesTabs,
//                 ),
//               ),
//             ];
//           },
//           body: const TabBarView(
//             children: [
//               AllServicesTabview(),
//               CommonServiceTabview(
//                 serviceName: "Batting",
//                 serviceData: 12,
//               ),
//               CommonServiceTabview(
//                 serviceName: "Bowling",
//                 serviceData: 8,
//               ),
//               CommonServiceTabview(
//                 serviceName: "Fielding",
//                 serviceData: 12,
//               ),
//               CommonServiceTabview(
//                 serviceName: "Match Organization",
//                 serviceData: 0,
//               ),
//               CommonServiceTabview(
//                 serviceName: "Find Teams",
//                 serviceData: 0,
//               ),
//               CommonServiceTabview(
//                 serviceName: "Hire Equipents",
//                 serviceData: 12,
//               ),
//             ],
//           ),
//           // children: findServicesTabs
//           //     .map(
//           //       (item) => SingleChildScrollView(
//           //         child: ListView.builder(
//           //           shrinkWrap: true,
//           //           physics: const NeverScrollableScrollPhysics(),
//           //           controller: _scrollController,
//           //           padding: EdgeInsets.zero,
//           //           itemCount: 20,
//           //           itemBuilder: (c, index) => ListTile(
//           //             title: Text('Service $index'),
//           //             subtitle: Text('Details about Service $index'),
//           //           ),
//           //         ),
//           //       ),
//           //     )
//           //     .toList()),
//         ),
//       ),
   