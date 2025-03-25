import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'Controller/filters_controller.dart';

class ServiceFilters extends ConsumerWidget {
  const ServiceFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(_selectedFilterIndexPr);

    return CupertinoPageScaffold(
      navigationBar: CupertinoAppbar(
        title: "Filters",
        previousPageTitle: "Home",
        showNotificationIcon: false,
        trailing: Consumer(
          builder: (_, WidgetRef ref, __) {
            return CommonTextButton(
              onPressed: () =>
                  ref.read(filterCategoryIndexPr.notifier).state = null,
              text: "Clear All",
            );
          },
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          minimum: Sizes.globalMargin,
          child: CommonButton(
            onPressed: () {
              AppRouter.instance.pop(context);
            },
            text: "Apply Filters",
          ),
        ),
        body: Padding(
          padding: Sizes.cupertinoScaffoldPadding(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _LeftMenuItems(
                  selectedIndex: selectedIndex,
                  ref: ref,
                ),
              ),
              const VerticalDivider(),
              Expanded(
                flex: 4,
                child: _RightMenuItems(
                  selectedIndex: selectedIndex,
                  ref: ref,
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Text(
      //       "Category:",
      //       style: TextStyle(
      //         fontSize: Sizes.fontSize18,
      //         fontWeight: FontWeight.bold,
      //         color: AppColors.black,
      //       ),
      //     ),
      //     const SizedBox(height: Sizes.spaceHeight),
      //     Consumer(
      //       builder: (_, WidgetRef ref, __) {
      //         final selected = ref.watch(filterCategoryIndexPr);
      //         return Wrap(
      //           spacing: Sizes.space,
      //           children: List.generate(
      //             findServicesTabs.length,
      //             (index) => ChoiceChip.elevated(
      //
      // color: selected == index ? AppColors.white : null,
      //               ),
      //               onSelected: (value) {
      //                 ref.read(filterCategoryIndexPr.notifier).state = index;
      //               },
      //               label: Text(findServicesTabs[index]),
      //               selected: selected == index,
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //     ///
      //   ],
      // ),
    );
  }
}

///Left Menu Items
class _LeftMenuItems extends StatelessWidget {
  const _LeftMenuItems({
    required this.selectedIndex,
    required this.ref,
  });

  final int selectedIndex;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        filters.length,
        (index) {
          return InkWell(
            onTap: () => ref
                .read(_selectedFilterIndexPr.notifier)
                .update((st) => st = index),
            child: SizedBox(
              height: 60,
              child: Stack(
                // clipBehavior: Clip.none,
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
  Positioned _buildHeader(int index) {
    return Positioned(
      left: 12,
      child: Text(
        filters[index],
        style: const TextStyle(
          color: AppColors.black,
          fontSize: Sizes.fontSize18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  ///Indicator Widget
  AnimatedPositioned _buildIndicator(int index) {
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
