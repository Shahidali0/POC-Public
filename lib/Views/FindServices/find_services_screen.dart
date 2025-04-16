import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindServicesScreen extends ConsumerWidget {
  const FindServicesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator.adaptive(
      onRefresh: () async => ref.invalidate(getAllServciesPr),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoAppbar(
          title: "Find Services",
          showNotificationIcon: true,
          trailing: CommonIconButton(
            onPressed: () => AppRouter.instance.animatedPush(
              context: context,
              type: MyAnimationType.upDown,
              screen: const ServiceFilters(),
            ),
            iconData: CupertinoIcons.slider_horizontal_3,
          ),
        ),
        child: ref.watch(getAllServciesPr).when(
              skipLoadingOnRefresh: false,
              data: (data) {
                if (data == null || (data.services?.isEmpty ?? false)) {
                  return const EmptyDataWidget();
                }

                return _body(
                  context: context,
                  allServices: data.services!,
                  ref: ref,
                );
              },
              error: (e, st) {
                final error = e as Failure;
                return ErrorText(
                  title: error.title,
                  error: error.message,
                  onRefresh: () async => ref.invalidate(getAllServciesPr),
                );
              },
              loading: () => const ShowDataLoader(),
            ),
      ),
    );
  }

  ///Body Widget
  Widget _body({
    required List<ServiceJson> allServices,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    return Stack(
      children: [
        ///List
        ListView.separated(
          padding: Sizes.cupertinoScaffoldPadding(context).add(
            const EdgeInsets.only(
              bottom: Sizes.spaceHeight * 2,
              // top: 50,
            ),
          ),
          itemCount: allServices.length,
          itemBuilder: (BuildContext context, int index) {
            return ServiceCardWidget(
              serviceJson: allServices[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: Sizes.space),
        ),

        ///If any Filter
        Positioned(
          top: -10,
          child: Padding(
            padding: Sizes.cupertinoScaffoldPadding(context),
            child: const SizedBox(height: 50),
          ),
        ),
      ],
    );
  }
}
