import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cricket_poc/lib_exports.dart';

class FindServicesScreen extends ConsumerWidget {
  const FindServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double filterHeight = 60;
    final updateFilters = ref.watch(filtersControllerPr).updateFilters;

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
        child: Stack(
          children: [
            ///List
            ref.watch(getAllServciesPr).when(
                  skipLoadingOnRefresh: false,
                  data: (data) {
                    if (data == null || (data.services?.isEmpty ?? false)) {
                      return const EmptyDataWidget();
                    }

                    return _body(
                      context: context,
                      allServices: data.services!,
                      updateFilters: updateFilters,
                      filterHeight: filterHeight,
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

            ///Filters --- If any applied
            if (updateFilters) _AppliedFiltersCard(filterHeight: filterHeight),
          ],
        ),
      ),
    );
  }

  ///Body Widget
  Widget _body({
    required BuildContext context,
    required List<ServiceJson> allServices,
    required bool updateFilters,
    required double filterHeight,
  }) {
    return ListView.separated(
      padding: Sizes.cupertinoScaffoldPadding(context).add(
        EdgeInsets.only(
          bottom: Sizes.spaceHeight * 2,
          top: updateFilters ? filterHeight : 0,
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
    );
  }
}

///Filetrs Card -- Shows Selected Filters
class _AppliedFiltersCard extends ConsumerWidget {
  const _AppliedFiltersCard({
    required this.filterHeight,
  });

  final double filterHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filtersControllerPr);

    return Positioned(
      top: -10,
      // right: 0,
      // left: 0,
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          // left: Sizes.space,
          // right: Sizes.space,
        ),
        height: filterHeight,
        width: Sizes.screenWidth(context),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: const [
            BoxShadow(
              color: AppColors.border,
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        child: Row(
          children: [
            ///List of filters
            Expanded(
              child: SingleChildScrollView(
                padding: Sizes.globalPadding * 0.7,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ///Sport
                    if (state.selectedSport.isNotEmpty)
                      _richText(
                        leadingText: "Sport: ",
                        title: state.selectedSport,
                      ),

                    ///Category
                    if (state.selectedCategory.isNotEmpty)
                      _richText(
                        leadingText: "Categroy: ",
                        title: state.selectedCategory,
                      ),

                    ///Sport
                    if (state.selectedSubCategory.isNotEmpty)
                      _richText(
                        leadingText: "SubCategory: ",
                        title: state.selectedSubCategory,
                      ),
                  ],
                ),
              ),
            ),

            const VerticalDivider(),

            ///Clear Button
            MenuItemButton(
              onPressed: () => ref
                  .read(filtersControllerPr.notifier)
                  .clearFilters(context: context),
              child: const Text(
                "Clear",
                style: TextStyle(color: AppColors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Rich Text
  Widget _richText({
    required String leadingText,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: Sizes.spaceMed),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        child: Padding(
          padding: Sizes.globalPadding,
          child: Text.rich(
            TextSpan(
              text: leadingText,
              children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
