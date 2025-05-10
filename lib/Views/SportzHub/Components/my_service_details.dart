import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'service_bookings_page.dart';

class MyServiceDetailsPage extends ConsumerWidget {
  const MyServiceDetailsPage({super.key, required this.serviceJson});

  final ServiceJson serviceJson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

              ///About Provider
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
                  child: ServiceProviderWidget(
                    showOnlyProfile: true,
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
                        Tab(text: "Pending"),
                        Tab(text: "Approved"),
                        Tab(text: "Canceled"),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: _bodyView(
            ref: ref,
            context: context,
            serviceJson: serviceJson,
          ),
        ),
      ),
    );
  }

  ///BodyView
  Widget _bodyView({
    required WidgetRef ref,
    required BuildContext context,
    required ServiceJson serviceJson,
  }) =>
      RefreshIndicator(
        onRefresh: () async =>
            ref.refresh(getMyServicesBookingsPr(serviceJson.serviceId!).future),
        child: ref.watch(getMyServicesBookingsPr(serviceJson.serviceId!)).when(
              data: (services) {
                ///For Empty Services List
                if (services.isEmpty) {
                  return const EmptyDataWidget(
                    subTitle: Constants.emmptyMyServicesBookings,
                  );
                }

                ///Data not empty
                return TabBarView(
                  children: [
                    //* My Requests
                    _MyServiceBookingsList(
                      bookingsJson: services
                          .where((service) => service.status!
                              .toLowerCase()
                              .contains(BookingStatus.pending.name))
                          .toList(),
                      showButtons: true,
                    ),

                    //* Approved
                    _MyServiceBookingsList(
                      bookingsJson: services
                          .where((service) => service.status!
                              .toLowerCase()
                              .contains(BookingStatus.confirmed.name))
                          .toList(),
                    ),

                    //* Canceled
                    _MyServiceBookingsList(
                      bookingsJson: services
                          .where((service) => service.status!
                              .toLowerCase()
                              .contains(BookingStatus.cancel.name))
                          .toList(),
                    ),
                  ],
                );
              },
              error: (e, st) {
                final error = e as Failure;
                return ErrorText(
                  title: error.title,
                  error: error.message,
                  onRefresh: () async => ref.invalidate(getMyBookingsPr),
                );
              },
              loading: () => const ShowDataLoader(),
            ),
      );
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
