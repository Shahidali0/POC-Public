import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyServicesTabview extends ConsumerWidget {
  const MyServicesTabview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(getMyServicesListPr.future),
      child: ref.watch(getMyServicesListPr).when(
            data: (data) {
              ///For Empty Services List
              if (data == null || (data.services?.isEmpty ?? false)) {
                return EmptyDataWidget(
                  subTitle:
                      "Let’s add your first service and get you SportZReady!",
                  widget: CommonOutlineButton(
                    minButtonWidth: 100,
                    dense: true,
                    onPressed: () => AppRouter.instance.animatedPush(
                      context: context,
                      page: const PostServiceScreen(),
                    ),
                    text: "Post Service",
                  ),
                );
              }

              return _body(
                context: context,
                myServices: data.services!,
                ref: ref,
              );
            },
            error: (e, st) {
              final error = e as Failure;
              return ErrorText(
                title: error.title,
                error: error.message,
                onRefresh: () async => ref.invalidate(getMyServicesListPr),
              );
            },
            loading: () => const ShowDataLoader(),
          ),
    );

    //   return FutureBuilder<AllServicesJson?>(
    //     future: _futureData,
    //     builder:
    //         (BuildContext context, AsyncSnapshot<AllServicesJson?> snapshot) {
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.waiting:
    //           return const ShowDataLoader();
    //         case ConnectionState.done:
    //         default:
    //           //*If SnapData has error
    //           if (snapshot.hasError) {
    //             final error = snapshot.error as Failure;
    //             return ErrorText(
    //               title: error.title,
    //               error: error.message,
    //             );
    //           }
    //           //*If SnapData is present
    //           else if (snapshot.hasData) {
    //             return _body(
    //               allServices: snapshot.data!.services!,
    //               ref: ref,
    //             );
    //           }
    //           //*If No Data Available
    //           else {
    //             return const EmptyDataWidget();
    //           }
    //       }
    //     },
    //   );
  }

  ///Body Widget
  Widget _body({
    required List<ServiceJson> myServices,
    required WidgetRef ref,
    required BuildContext context,
  }) =>
      ListView.separated(
        key: const PageStorageKey('MyServicesTabview'),
        physics: const NeverScrollableScrollPhysics(),
        padding: Sizes.globalMargin.add(
          const EdgeInsets.only(bottom: Sizes.spaceHeight * 5),
        ),
        itemCount: myServices.length,
        itemBuilder: (BuildContext context, int index) {
          return _MyServiceCard(
            serviceJson: myServices[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: Sizes.spaceHeight),
      );
}

///Service Card Widget
class _MyServiceCard extends StatelessWidget {
  const _MyServiceCard({
    required this.serviceJson,
  });

  final ServiceJson serviceJson;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRouter.instance.push(
        context: context,
        page: ServiceDetailsScreen(serviceJson: serviceJson),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: Sizes.globalPadding,
          child: Stack(
            children: [
              ///Card Items
              Column(
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
                    ],
                  ),

                  // ///Tag
                  // _buildListTile(
                  //   iconData: CupertinoIcons.person,
                  //   text: "John Smith",
                  //   color: AppColors.black.withOpacity(0.75),
                  //   context: context,
                  // ),

                  ///Description
                  const SizedBox(height: Sizes.space),
                  Padding(
                    padding: const EdgeInsets.only(right: Sizes.space),
                    child: Text(
                      serviceJson.description!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: Sizes.fontSize16,
                      ),
                    ),
                  ),
                  const SizedBox(height: Sizes.space),

                  ///Details
                  _buildListTile(
                    iconData: CupertinoIcons.pin,
                    text: serviceJson.location!,
                    context: context,
                  ),

                  _buildListTile(
                    iconData: CupertinoIcons.time,
                    text: Utils.instance.getDuration(serviceJson.duration),
                    context: context,
                  ),

                  // _buildListTile(
                  //   iconData: CupertinoIcons.money_dollar,
                  //   text: "40 per session",
                  //   color: AppColors.appTheme,
                  //   fontWeight: FontWeight.w700,
                  //   iconSize: 18,
                  // ),
                ],
              ),

              const Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Custom ListTile
  Widget _buildListTile({
    required IconData iconData,
    required String text,
    required BuildContext context,
    double? iconSize,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      ListTile(
        minTileHeight: 12,
        minVerticalPadding: 4,
        dense: true,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 2,
        visualDensity: VisualDensity.compact,
        leading: Icon(
          iconData,
          size: iconSize ?? 16,
          color: color,
        ),
        title: Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: kDefaultFontSize,
            color: color ?? AppColors.black,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
        ),
      );
}
