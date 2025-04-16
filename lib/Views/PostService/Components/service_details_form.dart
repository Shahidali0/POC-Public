part of 'package:cricket_poc/Views/PostService/post_service_screen.dart';

class _ServiceDetailsForm extends ConsumerWidget {
  const _ServiceDetailsForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(postServiceControllerPr.notifier);

    return Form(
      key: controller.serviceDetailsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Service Details",
            style: TextStyle(
              fontSize: Sizes.fontSize18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const Text(
            "Provide basic information about your service",
          ),
          const SizedBox(height: Sizes.spaceSmall),

          ///Service Title
          _ServiceTitleField(controller: controller.serviceTitleController),

          ///Service Sport
          const _ServiceSport(),
          // _ValidationErrorMessage(listenable: controller.sportValidation),

          ///Service Category
          const _ServiceCategory(),

          ///Service Sub-Category
          const _ServiceSubCategory(),

          ///Service Description
          _ServiceDescriptionField(
            controller: controller.serviceDescriptionController,
          ),
          const SizedBox(height: Sizes.spaceHeight),
        ],
      ),
    );
  }
}

///Service Title Field
class _ServiceTitleField extends StatelessWidget {
  const _ServiceTitleField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Service Title",
      isRequired: true,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        validator: FieldValidators.instance.commonValidator,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            hintText: "e.g., Professional Cricket Coaching Session"),
      ),
    );
  }
}

///Service Description Field
class _ServiceDescriptionField extends StatelessWidget {
  const _ServiceDescriptionField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Service Description",
      isRequired: true,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        validator: FieldValidators.instance.commonValidator,
        textCapitalization: TextCapitalization.words,
        maxLines: 7,
        minLines: 4,

        ///Limits 100 characters
        maxLength: 100,
        decoration: const InputDecoration(
          hintText:
              "Describe your service, what players can expect and any requirements...",
        ),
      ),
    );
  }
}

///Service Sport Type

class _ServiceSport extends ConsumerWidget {
  const _ServiceSport();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(postServiceControllerPr.notifier);
    final sport = ref.watch(postServiceControllerPr).selectedSport;

    return FormFiledWidget(
      title: "Service Sport",
      child: DropdownButtonFormField<String?>(
        padding: EdgeInsets.zero,
        menuMaxHeight: 300,
        alignment: Alignment.centerLeft,
        isExpanded: true,
        value: sport,
        validator: FieldValidators.instance.commonValidator,
        items: [
          const DropdownMenuItem<String>(
            child: Text(
              "Select Service Sport",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.blueGrey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ...controller.getSportsData.map((String valueItem) {
            return DropdownMenuItem<String>(
              value: valueItem,
              child: Text(
                valueItem,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.blueGrey,
                  fontSize: Sizes.defaultSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
            );
          }),
        ],
        onChanged: (value) {
          ref.read(postServiceControllerPr.notifier).updateSelectedSport(value);
        },
        decoration: const InputDecoration(hintText: "Select Service Sport"),
      ),
    );
  }
}
// class _ServiceSport extends ConsumerWidget {
//   const _ServiceSport();
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
// final controller = ref.read(postServiceControllerPr.notifier);
// final sport = ref.watch(postServiceControllerPr).selectedSport;
//     return FormFiledWidget(
//       title: "Service Sport",
//       isRequired: true,
//       child: Padding(
//         padding: const EdgeInsets.only(top: Sizes.spaceMed),
//         child: Wrap(
//           spacing: Sizes.spaceMed,
//           alignment: WrapAlignment.spaceAround,
//           children: List.generate(
//             controller.getSportsData.length,
//             (index) {
//               final item = controller.getSportsData[index];
//               bool isActive = sport == item;
//               return ChoiceChip(
//                 labelPadding: const EdgeInsets.symmetric(
//                   vertical: Sizes.spaceSmall,
//                   horizontal: Sizes.spaceHeight,
//                 ),
//                 labelStyle: TextStyle(
//                   color: isActive ? AppColors.white : null,
//                   fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
//                 ),
//                 onSelected: (v) => ref
//                     .read(postServiceControllerPr.notifier)
//                     .updateSelectedSport(item),
//                 avatar: isActive
//                     ? null
//                     : const Icon(
//                         Icons.games,
//                         color: AppColors.black,
//                       ),
//                 label: Text(item),
//                 selected: isActive,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

///Service Category Type
class _ServiceCategory extends ConsumerWidget {
  const _ServiceCategory();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(postServiceControllerPr.notifier);
    // final sport = ref.watch(postServiceControllerPr).selectedSport;
    final category = ref.watch(postServiceControllerPr).selectedCategory;

    return FormFiledWidget(
      title: "Service Category",
      child: DropdownButtonFormField<String?>(
        padding: EdgeInsets.zero,
        menuMaxHeight: 300,
        alignment: Alignment.centerLeft,
        isExpanded: true,
        value: category,
        validator: FieldValidators.instance.commonValidator,
        items: [
          const DropdownMenuItem<String>(
            child: Text(
              "Select Service Category",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.blueGrey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ...controller.getCategoriesData.map((String valueItem) {
            return DropdownMenuItem<String>(
              value: valueItem,
              child: Text(
                valueItem,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.blueGrey,
                  fontSize: Sizes.defaultSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
            );
          }),
        ],
        onChanged: (value) {
          ref
              .read(postServiceControllerPr.notifier)
              .updateSelectedCategory(value);
        },
        decoration: const InputDecoration(hintText: "Select Service Category"),
      ),
    );
  }
}

// class _ServiceCategory extends ConsumerWidget {
//   const _ServiceCategory();
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = ref.read(postServiceControllerPr.notifier);
//     final sport = ref.watch(postServiceControllerPr).selectedSport;
//     final category = ref.watch(postServiceControllerPr).selectedCategory;
//     return FormFiledWidget(
//       title: "Service Category",
//       isRequired: true,
//       child: AnimatedCrossFade(
//         duration: Sizes.durationS,
//         crossFadeState: sport.isEmpty
//             ? CrossFadeState.showFirst
//             : CrossFadeState.showSecond,
//         firstChild: const SizedBox.shrink(),
//         secondChild: Padding(
//           padding: const EdgeInsets.symmetric(vertical: Sizes.spaceMed),
//           child: Column(
//             children: [
//               ///Items
//               Wrap(
//                 spacing: Sizes.spaceMed,
//                 runSpacing: Sizes.spaceMed,
//                 alignment: WrapAlignment.spaceBetween,
//                 children: List.generate(
//                   controller.getCategoriesData.length,
//                   (index) {
//                     final item = controller.getCategoriesData[index];
//                     bool isActive = category == item;
//                     return ChoiceChip.elevated(
//                       padding: Sizes.globalPadding,
//                       labelStyle: TextStyle(
//                         color: isActive ? AppColors.white : null,
//                         fontWeight:
//                             isActive ? FontWeight.w700 : FontWeight.normal,
//                       ),
//                       onSelected: (v) => ref
//                           .read(postServiceControllerPr.notifier)
//                           .updateSelectedCategory(item),
//                       avatar: isActive
//                           ? null
//                           : const Icon(
//                               Icons.games,
//                               color: AppColors.black,
//                             ),
//                       label: Text(item),
//                       selected: isActive,
//                     );
//                   },
//                 ),
//               ),
//               ///Validation
//               _ValidationErrorMessage(
//                   listenable: controller.categoryValidation),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

///Service SubCategory Type
class _ServiceSubCategory extends ConsumerWidget {
  const _ServiceSubCategory();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(postServiceControllerPr.notifier);
    final subCategory = ref.watch(postServiceControllerPr).selectedSubCategory;

    return FormFiledWidget(
      title: "Service Sub Category",
      child: DropdownButtonFormField<String?>(
        padding: EdgeInsets.zero,
        menuMaxHeight: 300,
        alignment: Alignment.centerLeft,
        isExpanded: true,
        value: subCategory,
        validator: FieldValidators.instance.commonValidator,
        items: [
          const DropdownMenuItem<String>(
            child: Text(
              "Select Service Sub Category",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.blueGrey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ...controller.getSubCategoriesData.map((String valueItem) {
            return DropdownMenuItem<String>(
              value: valueItem,
              child: Text(
                valueItem,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.blueGrey,
                  fontSize: Sizes.defaultSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
            );
          }),
        ],
        onChanged: (value) {
          ref
              .read(postServiceControllerPr.notifier)
              .updateSelectedSubCategory(value);
        },
        decoration:
            const InputDecoration(hintText: "Select Service Sub-Category"),
      ),
    );
  }
}

// class _ServiceSubCategory extends ConsumerWidget {
//   const _ServiceSubCategory();
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = ref.read(postServiceControllerPr.notifier);
//     final sport = ref.watch(postServiceControllerPr).selectedSport;
//     final category = ref.watch(postServiceControllerPr).selectedCategory;
//     final subCategory = ref.watch(postServiceControllerPr).selectedSubCategory;
//     return FormFiledWidget(
//       title: "Service Sub-Category",
//       isRequired: true,
//       child: AnimatedCrossFade(
//         duration: Sizes.durationS,
//         crossFadeState: sport.isEmpty || category.isEmpty
//             ? CrossFadeState.showFirst
//             : CrossFadeState.showSecond,
//         firstChild: const SizedBox.shrink(),
//         secondChild: Padding(
//           padding: const EdgeInsets.symmetric(vertical: Sizes.spaceMed),
//           child: Column(
//             children: [
//               ///Items
//               Wrap(
//                 spacing: Sizes.spaceMed,
//                 runSpacing: Sizes.spaceMed,
//                 alignment: WrapAlignment.spaceBetween,
//                 children: List.generate(
//                   controller.getSubCategoriesData.length,
//                   (index) {
//                     final item = controller.getSubCategoriesData[index];
//                     bool isActive = subCategory == item;
//                     return ChoiceChip.elevated(
//                       padding: Sizes.globalPadding,
//                       labelStyle: TextStyle(
//                         color: isActive ? AppColors.white : null,
//                         fontWeight:
//                             isActive ? FontWeight.w700 : FontWeight.normal,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       onSelected: (v) => ref
//                           .read(postServiceControllerPr.notifier)
//                           .updateSelectedSubCategory(item),
//                       avatar: isActive
//                           ? null
//                           : const Icon(
//                               Icons.games,
//                               color: AppColors.black,
//                             ),
//                       label: Text(item),
//                       selected: isActive,
//                     );
//                   },
//                 ),
//               ),
//               ///Validation
//               _ValidationErrorMessage(
//                 listenable: controller.subCategoryValidation,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
