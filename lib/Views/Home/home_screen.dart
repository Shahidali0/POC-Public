import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

part 'Components/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: homeTabbarItemsData.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const _HomeTitleAppBar(),
            HomeSearchbarWithTabs(tabController: _tabController),
          ];
        },
        body: Padding(
          padding: Sizes.globalMargin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Featured Services",
                style: TextStyle(
                  fontSize: Sizes.fontSize20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.appTheme,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: Sizes.spaceHeight),
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return const CardWidget();
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: Sizes.spaceHeight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///Common Card Widget
class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
  });

  // ///OnTap BookNow
  // void _onBookNow(BuildContext context) => AppRouter.instance.push(
  //       context: context,
  //       screen: const ServiceDetailsScreen(),
  //     );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => _onBookNow(context),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: Sizes.globalMargin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "Elite Match Organization",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Sizes.fontSize18,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  ///Price Tag
                  Text(
                    r"$ 399",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.fontSize16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // Text(
                  //   "⭐️4.6",
                  //   style: TextStyle(
                  //     fontSize: Sizes.fontSize12,
                  //     color: AppColors.orange,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                ],
              ),

              const SizedBox(height: Sizes.spaceMed),

              ///Tag
              const CustomTile(
                iconData: CupertinoIcons.person,
                text: "Elite Match Organization",
              ),

              ///Details
              const CustomTile(
                iconData: CupertinoIcons.map_pin_ellipse,
                text: "Melbourne Cricket Ground",
              ),
              const CustomTile(
                iconData: CupertinoIcons.timer,
                text: "180 mins",
              ),

              ///View Details Button
              CommonTextButton(
                onPressed: () {},
                text: "View Details",
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  // return GestureDetector(
  //     onTap: () => _onBookNow(context),
  //     child: Card(
  //       margin: EdgeInsets.zero,
  //       child: Padding(
  //         padding: Sizes.globalPadding,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             ///Header
  //             const Row(
  //               children: [
  //                 Expanded(
  //                   child: Text(
  //                     "Elite Match Organization",
  //                     maxLines: 2,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(
  //                       fontSize: Sizes.fontSize18,
  //                       color: AppColors.black,
  //                       fontWeight: FontWeight.w800,
  //                     ),
  //                   ),
  //                 ),

  //                 ///Rating
  //                 Text(
  //                   "⭐️4.6",
  //                   style: TextStyle(
  //                     fontSize: Sizes.fontSize12,
  //                     color: AppColors.orange,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ],
  //             ),

  //             ///Tag
  //             const CustomTile(
  //               iconData: CupertinoIcons.person,
  //               text: "Elite Match Organization",
  //             ),

  //             ///Description
  //             const SizedBox(height: Sizes.space),
  //             const Text(
  //               "Premium match organization with top-tier grounds and professional umpires",
  //               maxLines: 3,
  //               overflow: TextOverflow.ellipsis,
  //               style: TextStyle(
  //                 color: AppColors.black,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             const Divider(),

  //             ///Details
  //             const CustomTile(
  //               iconData: CupertinoIcons.map_pin_ellipse,
  //               text: "Melbourne Cricket Ground",
  //             ),
  //             const CustomTile(
  //               iconData: CupertinoIcons.timer,
  //               text: "180 mins",
  //             ),
  //             const Divider(),

  //             ///Book Now
  //             Row(
  //               children: [
  //                 const Expanded(
  //                   flex: 2,
  //                   child: Text(
  //                     r"$399",
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(
  //                       fontSize: Sizes.fontSize16,
  //                       color: AppColors.appTheme,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ),

  //                 ///Button
  //                 Expanded(
  //                   child: CommonButton(
  //                     onPressed: () => _onBookNow(context),
  //                     text: "Book Now",
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
 