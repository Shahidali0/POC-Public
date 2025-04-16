part of 'package:cricket_poc/Views/Filters/service_filter.dart';

///This is for [SORT BY] Widget
class _SportTypeWidget extends StatelessWidget {
  const _SportTypeWidget({
    required this.ref,
    required this.controller,
  });

  final WidgetRef ref;
  final _FiltersController controller;

  @override
  Widget build(BuildContext context) {
    final sport = ref.watch(filtersControllerPr).selectedSport;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Sizes.spaceHeight),
        const Text(
          "SPORT",
          style: TextStyle(letterSpacing: 1),
        ),

        const SizedBox(height: Sizes.spaceHeight),

        ///RadioListTiles
        ...controller.getSportsData.map(
          (value) {
            return RadioListTile<String>.adaptive(
              value: value,
              groupValue: sport,
              onChanged: (String? value) {
                controller.updateSportValue(value);
              },
              title: Text(value),
            );
          },
        ),
      ],
    );
  }
}

///This is for [Categories] Types
class _CategoryTypeWidget extends StatelessWidget {
  const _CategoryTypeWidget({
    required this.ref,
    required this.controller,
  });

  final WidgetRef ref;
  final _FiltersController controller;

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(filtersControllerPr).selectedCategory;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Sizes.spaceHeight),
        const Text(
          "CATEGORY",
          style: TextStyle(letterSpacing: 1),
        ),

        const SizedBox(height: Sizes.spaceHeight),

        ///RadioListTiles--Categories
        ...controller.getCategoriesData.map((value) {
          return RadioListTile<String>.adaptive(
            value: value,
            groupValue: category,
            onChanged: (String? value) {
              controller.updateCategoryValue(value);
            },
            title: Text(value),
          );
        }),
      ],
    );
  }
}

///This is for [Sub-Categories] Types
class _SubCategoryTypeWidget extends StatelessWidget {
  const _SubCategoryTypeWidget({
    required this.ref,
    required this.controller,
  });

  final WidgetRef ref;
  final _FiltersController controller;

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(filtersControllerPr).selectedCategory;
    final subCategory = ref.watch(filtersControllerPr).selectedSubCategory;

    if (category.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Sizes.spaceHeight),
        const Text(
          "SUB-CATEGORY",
          style: TextStyle(letterSpacing: 1),
        ),

        const SizedBox(height: Sizes.spaceHeight),

        ///RadioListTiles -- SubCategories
        ...controller.getSubCategoriesData.map((value) {
          return RadioListTile<String>.adaptive(
            value: value,
            groupValue: subCategory,
            onChanged: (String? value) {
              controller.updateSubCategoryValue(value);
            },
            title: Text(value),
          );
        }),
      ],
    );
  }
}

// ///This is for [Price] Types
// class _PriceTypeWidget extends StatelessWidget {
//   const _PriceTypeWidget({
//     required this.ref,
//     required this.controller,
//   });

//   final WidgetRef ref;
//   final _FiltersController controller;

//   @override
//   Widget build(BuildContext context) {
//     final price = ref.watch(filtersControllerPr).selectedPrice;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: Sizes.spaceHeight),
//         const Text(
//           "PRICE",
//           style: TextStyle(letterSpacing: 1),
//         ),

//         const SizedBox(height: Sizes.spaceHeight),

//         ///RadioListTiles
//         ...[
//           "\$ 50 and Below",
//           "\$ 50 - \$ 100",
//           "\$ 100 - \$ 500",
//           "\$ 500 and Above",
//         ].map((value) {
//           return RadioListTile<String>.adaptive(
//             value: value,
//             groupValue: price,
//             onChanged: (String? value) {
//               controller.updatePriceValue(value);
//             },
//             title: Text(value),
//           );
//         }),
//       ],
//     );
//   }
// }

// ///This is for location [Distance]
// class _DistanceWidget extends StatelessWidget {
//   const _DistanceWidget({
//     required this.ref,
//     required this.controller,
//   });

//   final WidgetRef ref;
//   final _FiltersController controller;

//   @override
//   Widget build(BuildContext context) {
//     final distance = ref.watch(filtersControllerPr).selectedDistance;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: Sizes.spaceHeight),
//         const Text(
//           "DISTANCE",
//           style: TextStyle(letterSpacing: 1),
//         ),

//         const SizedBox(height: Sizes.spaceHeight),

//         Center(
//           child: Text(
//             "${(distance * 100).round()} km",
//             style: const TextStyle(
//               letterSpacing: 1,
//               fontSize: Sizes.fontSize16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),

//         ///Slider
//         Slider.adaptive(
//           min: 0.1,
//           max: 1,
//           value: distance,
//           onChanged: (changedValue) {
//             controller.updateDistanceValue(changedValue);
//           },
//         ),
//       ],
//     );
//   }
// }
