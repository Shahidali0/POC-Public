import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class FeaturedServicesList extends ConsumerWidget {
  const FeaturedServicesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getFeaturedServicesFtPr).when(
          data: (data) {
            if (data == null || data.services!.isEmpty) {
              return const SizedBox.shrink();
            }

            return _body(
              context: context,
              featuredServices: data.services!,
            );
          },
          error: (e, st) {
            final error = e as Failure;
            debugPrint("ERROR:${error.message.toString()}");
            return const SizedBox.shrink();
          },
          loading: () => const _ShimmerCard(),
        );
  }

  ///Body
  Widget _body({
    required BuildContext context,
    required List<ServiceJson> featuredServices,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Header
          const HomeHeaderText(
            title: "Featured Services",
          ),

          ///Featured List
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(vertical: Sizes.spaceHeightSm),
              itemCount: featuredServices.length,
              itemBuilder: (BuildContext context, int index) {
                final item = featuredServices[index];

                return SizedBox(
                  width: 310,
                  // width: size.width * 0.75,
                  child: ServiceCardWidget(serviceJson: item),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: Sizes.spaceHeight),
            ),
          ),

          const SizedBox(height: Sizes.spaceHeightSm),
        ],
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
