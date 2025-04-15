import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeaturedServicesList extends ConsumerWidget {
  const FeaturedServicesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getFeaturedServicesPr).when(
          skipLoadingOnRefresh: false,
          data: (data) {
            if (data == null) {
              return const EmptyDataWidget();
            }

            return _body(
              context: context,
              featuredServices: data.services!,
            );
          },
          error: (e, st) {
            final error = e as Failure;
            return ErrorText(
              title: error.title,
              error: error.message,
              onRefresh: () async => ref.invalidate(findAllServciesPr),
            );
          },
          loading: () => const _ShimmerCard(),
        );
  }

  ///Body
  Widget _body({
    required BuildContext context,
    required List<ServiceJson> featuredServices,
  }) =>
      SizedBox(
        height: 240,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: Sizes.spaceHeightSm),
          itemCount: featuredServices.length,
          itemBuilder: (BuildContext context, int index) {
            final item = featuredServices[index];
            return _FeaturedServiceCard(item: item);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: Sizes.spaceHeight),
        ),
      );
}

///Shimmer card for featured services
class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: Sizes.spaceHeightSm),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return _shimmerBody(context);
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: Sizes.spaceHeight),
      ),
    );
  }

  ///Shimmer Body
  Widget _shimmerBody(BuildContext context) => Card(
        margin: EdgeInsets.zero,
        child: Container(
          width: Sizes.screenWidth(context) * 0.7,
          padding: Sizes.globalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: _skeleton()),
                  const SizedBox(width: 10),
                  _skeleton(width: 50),
                ],
              ),

              const SizedBox(height: Sizes.spaceHeight),

              ///Tag
              Row(
                children: [
                  _skeleton(width: 30),
                  const SizedBox(width: 10),
                  Expanded(child: _skeleton()),
                  const SizedBox(width: 50),
                ],
              ),
              const SizedBox(height: Sizes.spaceHeightSm),

              ///Details
              Row(
                children: [
                  _skeleton(width: 30),
                  const SizedBox(width: 10),
                  Expanded(child: _skeleton()),
                  const SizedBox(width: 50),
                ],
              ),
              const SizedBox(height: Sizes.spaceHeightSm),

              ///Duration
              Row(
                children: [
                  _skeleton(width: 30),
                  const SizedBox(width: 10),
                  Expanded(child: _skeleton()),
                  const SizedBox(width: 50),
                ],
              ),

              const SizedBox(height: Sizes.spaceHeight),

              ///View Details Button
              _skeleton(width: 60),
            ],
          ),
        ),
      );

  ///Skeleton
  Widget _skeleton({
    double? width,
  }) =>
      Shimmer.fromColors(
        baseColor: Colors.black26,
        highlightColor: Colors.white,
        child: Container(
          width: width,
          padding: Sizes.globalPadding * 0.6,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
          ),
        ),
      );
}

///Common Card Widget
class _FeaturedServiceCard extends StatelessWidget {
  const _FeaturedServiceCard({required this.item});

  final ServiceJson item;

  ///OnTap BookNow
  void _onTap(BuildContext context) => AppRouter.instance.push(
        context: context,
        screen: ServiceDetailsScreen(serviceJson: item),
      );

  @override
  Widget build(BuildContext context) {
    final size = Sizes.screenSize(context);

    return SizedBox(
      width: size.width * 0.75,
      child: GestureDetector(
        onTap: () => _onTap(context),
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
                        item.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: Sizes.fontSize16,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: Sizes.spaceMed),

                    ///Price Tag
                    Text(
                      "\$ ${item.price}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: Sizes.fontSize16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: Sizes.spaceMed),

                ///Tag
                CustomTile(
                  iconData: CupertinoIcons.link,
                  text: item.category?.capitalize ?? "--",
                ),

                ///Details
                CustomTile(
                  iconData: CupertinoIcons.map_pin_ellipse,
                  text: item.location?.capitalize ?? "--",
                ),
                CustomTile(
                  iconData: CupertinoIcons.timer,
                  text: "${Utils.instance.getDuration(item.duration)} minutes",
                ),

                ///View Details Button
                CommonTextButton(
                  onPressed: () => _onTap(context),
                  text: "View Details",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
