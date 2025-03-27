part of 'package:cricket_poc/Views/Filters/service_filter.dart';

///This is for [SORT BY] Widget
class _SortTypeWidget extends StatelessWidget {
  const _SortTypeWidget({required this.controller});

  final _FiltersController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: controller.sortValue,
      builder: (BuildContext context, String? groupValue, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Sizes.spaceHeight),
            const Text(
              "SORT BY",
              style: TextStyle(letterSpacing: 1),
            ),

            const SizedBox(height: Sizes.spaceHeight),

            ///RadioListTiles
            ...[
              "Relevance (Default)",
              "Cost: Low to High",
              "Cost: High to Low",
              "Rating",
            ].map((value) {
              return RadioListTile<String>.adaptive(
                value: value,
                groupValue: groupValue,
                onChanged: (String? value) {
                  controller.sortValue.value = value;
                },
                title: Text(value),
              );
            }),
          ],
        );
      },
    );
  }
}

///This is for [Categories] Types
class _CategoryTypeWidget extends StatelessWidget {
  const _CategoryTypeWidget({required this.controller});

  final _FiltersController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: controller.categoryValue,
      builder: (BuildContext context, String? groupValue, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Sizes.spaceHeight),
            const Text(
              "CATEGORY",
              style: TextStyle(letterSpacing: 1),
            ),

            const SizedBox(height: Sizes.spaceHeight),

            ///RadioListTiles
            ...serviceCategoriesData.map((value) {
              return RadioListTile<String>.adaptive(
                value: value,
                groupValue: groupValue,
                onChanged: (String? value) {
                  controller.categoryValue.value = value;
                },
                title: Text(value),
              );
            }),
          ],
        );
      },
    );
  }
}

///This is for [Sub-Categories] Types
class _SubCategoryTypeWidget extends StatelessWidget {
  const _SubCategoryTypeWidget({required this.controller});

  final _FiltersController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: controller.subCategoryValue,
      builder: (BuildContext context, String? groupValue, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Sizes.spaceHeight),
            const Text(
              "SUB-CATEGORY",
              style: TextStyle(letterSpacing: 1),
            ),

            const SizedBox(height: Sizes.spaceHeight),

            ///RadioListTiles
            ...specializationsData.map((value) {
              return RadioListTile<String>.adaptive(
                value: value,
                groupValue: groupValue,
                onChanged: (String? value) {
                  controller.subCategoryValue.value = value;
                },
                title: Text(value),
              );
            }),
          ],
        );
      },
    );
  }
}

///This is for [Price] Types
class _PriceTypeWidget extends StatelessWidget {
  const _PriceTypeWidget({required this.controller});

  final _FiltersController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: controller.priceValue,
      builder: (BuildContext context, String? groupValue, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Sizes.spaceHeight),
            const Text(
              "PRICE",
              style: TextStyle(letterSpacing: 1),
            ),

            const SizedBox(height: Sizes.spaceHeight),

            ///RadioListTiles
            ...[
              "\$ 50 and Below",
              "\$ 50 - \$ 100",
              "\$ 100 - \$ 500",
              "\$ 500 and Above",
            ].map((value) {
              return RadioListTile<String>.adaptive(
                value: value,
                groupValue: groupValue,
                onChanged: (String? value) {
                  controller.priceValue.value = value;
                },
                title: Text(value),
              );
            }),
          ],
        );
      },
    );
  }
}

///This is for location [Distance]
class _DistanceWidget extends StatelessWidget {
  const _DistanceWidget({required this.controller});

  final _FiltersController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: controller.distanceValue,
      builder: (BuildContext context, double distance, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Sizes.spaceHeight),
            const Text(
              "DISTANCE",
              style: TextStyle(letterSpacing: 1),
            ),

            const SizedBox(height: Sizes.spaceHeight),

            Center(
              child: Text(
                "${(distance * 100).round()} km",
                style: const TextStyle(
                  letterSpacing: 1,
                  fontSize: Sizes.fontSize16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            ///Slider
            Slider.adaptive(
              min: 0.1,
              max: 1,
              value: distance,
              onChanged: (changedValue) {
                controller.distanceValue.value = changedValue;
              },
            ),
          ],
        );
      },
    );
  }
}
