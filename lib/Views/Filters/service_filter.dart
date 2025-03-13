import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceFilters extends StatelessWidget {
  const ServiceFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCupertinoPageScaffold(
      title: "Filters",
      previousPageTitle: "Home",
      trailing: Consumer(
        builder: (_, WidgetRef ref, __) {
          return CommonTextButton(
            onPressed: () =>
                ref.read(filterCategoryIndexPr.notifier).state = null,
            text: "Clear All",
            backgroundColor: AppColors.transparent,
          );
        },
      ),
      bottomNavBar: SafeArea(
        minimum: Sizes.globalMargin,
        child: CommonButton(
          onPressed: () {
            AppRouter.instance.pop(context);
          },
          text: "Apply Filters",
        ),
      ),
      body: ListView(
        children: [
          const Text(
            "Category:",
            style: TextStyle(
              fontSize: Sizes.fontSize18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: Sizes.spaceHeight),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final selected = ref.watch(filterCategoryIndexPr);
              return Wrap(
                spacing: Sizes.space,
                children: List.generate(
                  findServicesTabs.length,
                  (index) => ChoiceChip.elevated(
                    labelStyle: TextStyle(
                      color: selected == index ? AppColors.white : null,
                    ),
                    onSelected: (value) {
                      ref.read(filterCategoryIndexPr.notifier).state = index;
                    },
                    label: Text(findServicesTabs[index]),
                    selected: selected == index,
                  ),
                ),
              );
            },
          ),

          ///
        ],
      ),
    );
  }
}
