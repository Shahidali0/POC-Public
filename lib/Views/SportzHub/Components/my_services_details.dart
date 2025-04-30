import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class MyServicesDetailsPage extends StatelessWidget {
  const MyServicesDetailsPage({super.key, required this.serviceJson});

  final ServiceJson serviceJson;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const MyCupertinoSliverAppbar(
                previousPageTitle: "SportZHub",
                title: "My Service",
              ),

              /// My Details
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///About Provider
                      ServiceProviderWidget(
                        serviceJson: serviceJson,
                        trailing: Text(
                          "\$ ${serviceJson.price}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.fontSize16,
                          ),
                        ),
                      ),

                      /// Description
                      ServiceDescriptionWidget(serviceJson: serviceJson),

                      /// Available Session Dates
                      ServiceAvailableDatesWidget(serviceJson: serviceJson),

                      /// Available Session TimeSlots
                      ServiceAvailableTimeSlotsWidget(serviceJson: serviceJson),
                    ],
                  ),
                ),
              ),

              /// Fixed TabBar
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverTabBarDelegate(
                    TabBar(
                      indicator: ShapeDecoration(
                        shape: ContinuousRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Sizes.borderRadius),
                        ),
                        color: AppColors.appTheme,
                      ),
                      labelColor: AppColors.white,
                      tabs: const [
                        Tab(text: "My Requests"),
                        Tab(text: "Approved"),
                        Tab(text: "Canceled"),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ServiceOffersPage(
                serviceJson: serviceJson,
                showButtons: true,
              ),
              const SizedBox(),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fixed TabBar
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Card(
      margin: EdgeInsets.zero,
      shape: ContinuousRectangleBorder(
        side: const BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
