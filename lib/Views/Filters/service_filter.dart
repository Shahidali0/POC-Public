import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'Controller/filters_controller.dart';
part 'Components/filter_types.dart';

class ServiceFilters extends ConsumerStatefulWidget {
  const ServiceFilters({super.key});

  @override
  ConsumerState<ServiceFilters> createState() => _ServiceFiltersState();
}

class _ServiceFiltersState extends ConsumerState<ServiceFilters> {
  late _FiltersController _controller;

  @override
  void initState() {
    _controller = ref.read(filtersControllerPr.notifier);
    _controller.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(_selectedFilterIndexPr);
    final isLoading = ref.watch(filtersControllerPr).loading;

    return Scaffold(
      bottomNavigationBar: _controller.allCategories.isEmpty
          ? null
          : SafeArea(
              minimum: Sizes.globalMargin,
              child: CommonButton(
                onPressed: () {
                  AppRouter.instance.pop(context);
                },
                text: "Apply Filters",
              ),
            ),
      body: _bodyView(
        context: context,
        selectedIndex: selectedIndex,
        isLoading: isLoading,
      ),
    );
  }

  ///BodyView
  Widget _bodyView({
    required BuildContext context,
    required int selectedIndex,
    required bool isLoading,
  }) {
    if (isLoading) {
      return const ShowDataLoader();
    }

    return CupertinoPageScaffold(
      ///AppBar
      navigationBar: CupertinoAppbar(
        title: "Filters",
        previousPageTitle: "Home",
        showNotificationIcon: false,
        trailing: Consumer(
          builder: (_, WidgetRef ref, __) {
            return CommonTextButton(
              onPressed: () => _controller.clearFilters(),
              text: "Clear All",
              textColor: AppColors.red,
            );
          },
        ),
      ),

      ///Body
      child: _controller.allCategories.isEmpty
          ? ErrorText(
              title: "Something went wrong",
              error: "Please try to refresh the page",
              onRefresh: _controller.loadAllCategories,
            )
          : Padding(
              padding: Sizes.cupertinoScaffoldPadding(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _LeftMenuItems(
                      selectedIndex: selectedIndex,
                      ref: ref,
                      controller: _controller,
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    flex: 4,
                    child: AnimatedSwitcher(
                      duration: Sizes.duration,
                      key: Key("selectedIndex:$selectedIndex"),
                      child: IndexedStack(
                        index: selectedIndex,
                        children: [
                          _SportTypeWidget(
                            controller: _controller,
                            ref: ref,
                          ),
                          _CategoryTypeWidget(
                            controller: _controller,
                            ref: ref,
                          ),
                          _SubCategoryTypeWidget(
                            controller: _controller,
                            ref: ref,
                          ),
                          _PriceTypeWidget(
                            controller: _controller,
                            ref: ref,
                          ),
                          _DistanceWidget(
                            controller: _controller,
                            ref: ref,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

///Left Menu Items
class _LeftMenuItems extends StatelessWidget {
  const _LeftMenuItems({
    required this.selectedIndex,
    required this.ref,
    required this.controller,
  });

  final int selectedIndex;
  final WidgetRef ref;
  final _FiltersController controller;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(filtersControllerPr);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        controller.filtersData.length,
        (index) {
          if ((state.selectedCategory.isEmpty || state.selectedSport.isEmpty) &&
              index == 2) {
            return const SizedBox.shrink();
          }

          return InkWell(
            onTap: () => ref
                .read(_selectedFilterIndexPr.notifier)
                .update((st) => st = index),
            child: SizedBox(
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ///Header Title
                  _buildHeader(index),

                  _buildIndicator(index),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///Header Widget
  Widget _buildHeader(int index) {
    return Positioned(
      left: 12,
      child: Text(
        controller.filtersData[index],
        style: const TextStyle(
          color: AppColors.black,
          fontSize: Sizes.fontSize18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  ///Indicator Widget
  Widget _buildIndicator(int index) {
    return AnimatedPositioned(
      duration: Sizes.duration,
      left: -3,
      bottom: 0,
      top: 0,
      width: selectedIndex == index ? 10 : 0,
      child: Container(
        // width: 8,
        decoration: const BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(Sizes.borderRadius),
          ),
        ),
      ),
    );
  }
}

///Right Menu Items
class _RightMenuItems extends StatefulWidget {
  const _RightMenuItems({
    required this.selectedIndex,
    required this.ref,
  });

  final int selectedIndex;
  final WidgetRef ref;

  @override
  State<_RightMenuItems> createState() => _RightMenuItemsState();
}

class _RightMenuItemsState extends State<_RightMenuItems> {
  String? selectedGroupValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Sizes.spaceHeight),
        const Text(
          "SORT BY",
          style: TextStyle(letterSpacing: 1),
        ),
        const SizedBox(height: Sizes.spaceHeight),

        ///Relevance
        RadioListTile<String>.adaptive(
          value: "Relevance (Default)",
          groupValue: selectedGroupValue,
          onChanged: (String? value) {
            setState(() {
              selectedGroupValue = value;
            });
          },
          title: const Text("Relevance (Default)"),
        ),

        ///Cost: Low to High
        RadioListTile<String>.adaptive(
          value: "Cost: Low to High",
          groupValue: selectedGroupValue,
          onChanged: (String? value) {
            setState(() {
              selectedGroupValue = value;
            });
          },
          title: const Text("Cost: Low to High"),
        ),

        ///Cost: High to Low
        RadioListTile<String>.adaptive(
          value: "Cost: High to Low",
          groupValue: selectedGroupValue,
          onChanged: (String? value) {
            setState(() {
              selectedGroupValue = value;
            });
          },
          title: const Text("Cost: High to Low"),
        ),

        ///Rating
        RadioListTile<String>.adaptive(
          value: "Rating",
          groupValue: selectedGroupValue,
          onChanged: (String? value) {
            setState(() {
              selectedGroupValue = value;
            });
          },
          title: const Text("Rating"),
        ),
      ],
    );
  }
}
