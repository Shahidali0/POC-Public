import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindServicesScreen extends ConsumerWidget {
  const FindServicesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoAppbar(
        title: "Find Services",
        trailing: CommonIconButton(
          onPressed: () => AppRouter.instance.animatedPush(
            context: context,
            type: MyAnimationType.upDown,
            screen: const ServiceFilters(),
          ),
          iconData: CupertinoIcons.slider_horizontal_3,
        ),
      ),
      child: ref.watch(findAllServciesPr).when(
            data: (data) {
              if (data == null) {
                return const EmptyDataWidget();
              }

              return RefreshIndicator.adaptive(
                onRefresh: () async => ref.invalidate(findAllServciesPr),
                child: _body(
                  context: context,
                  allServices: data.services!,
                  ref: ref,
                ),
              );
            },
            error: (e, st) {
              final error = e as Failure;
              return ErrorText(
                title: error.title,
                error: error.message,
              );
            },
            loading: () => const ShowDataLoader(),
          ),
    );
  }

  ///Body Widget
  Widget _body({
    required List<ServiceJson> allServices,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    return ListView.separated(
      padding: Sizes.cupertinoScaffoldPadding(context).add(
        const EdgeInsets.only(bottom: Sizes.spaceHeight * 5),
      ),
      itemCount: allServices.length,
      itemBuilder: (BuildContext context, int index) {
        return _CardWidget(
          serviceJson: allServices[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: Sizes.space),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    required this.serviceJson,
  });

  final ServiceJson serviceJson;

  ///OnTap BookNow
  void _onBookNow(BuildContext context) => AppRouter.instance.push(
        context: context,
        screen: ServiceDetailsScreen(serviceJson: serviceJson),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onBookNow(context),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: Sizes.globalMargin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      serviceJson.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: Sizes.fontSize18,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  ///Price Tag
                  Text(
                    "\$ ${serviceJson.price}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
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
              CustomTile(
                iconData: CupertinoIcons.person,
                text: serviceJson.category!.capitalizeFirst,
              ),

              ///Details
              CustomTile(
                iconData: CupertinoIcons.map_pin_ellipse,
                text: serviceJson.location!,
              ),

              CustomTile(
                iconData: CupertinoIcons.timer,
                text: Utils.instance.getDuration(serviceJson.duration),
              ),

              ///View Details Button
              CommonTextButton(
                onPressed: () => _onBookNow(context),
                text: "View Details",
              ),
            ],
          ),
        ),
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
   