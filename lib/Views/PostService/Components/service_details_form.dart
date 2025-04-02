import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class PostServiceDetailsForm extends ConsumerWidget {
  const PostServiceDetailsForm({super.key});

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
          _ServiceSport(
            controller: controller,
            ref: ref,
          ),
          _ValidationErrorMessage(listenable: controller.sportValidation),

          ///Service Category
          _ServiceCategory(
            controller: controller,
            ref: ref,
          ),

          ///Service Sub-Category
          _ServiceSubCategory(
            controller: controller,
            ref: ref,
          ),

          ///Service Description
          _ServiceDescriptionField(
              controller: controller.serviceDescriptionController),
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
class _ServiceSport extends StatelessWidget {
  const _ServiceSport({
    required this.controller,
    required this.ref,
  });

  final PostServiceController controller;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final sport = ref.watch(postServiceControllerPr).selectedSport;

    return FormFiledWidget(
      title: "Service Sport",
      isRequired: true,
      child: Padding(
        padding: const EdgeInsets.only(top: Sizes.spaceMed),
        child: Wrap(
          spacing: Sizes.spaceMed,
          alignment: WrapAlignment.spaceAround,
          children: List.generate(
            controller.getSportsData.length,
            (index) {
              final item = controller.getSportsData[index];
              bool isActive = sport == item;

              return ChoiceChip(
                labelPadding: const EdgeInsets.symmetric(
                  vertical: Sizes.spaceSmall,
                  horizontal: Sizes.spaceHeight,
                ),
                labelStyle: TextStyle(
                  color: isActive ? AppColors.white : null,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
                ),
                onSelected: (v) => ref
                    .read(postServiceControllerPr.notifier)
                    .updateSelectedSport(item),
                avatar: isActive
                    ? null
                    : const Icon(
                        Icons.games,
                        color: AppColors.black,
                      ),
                label: Text(item),
                selected: isActive,
              );
            },
          ),
        ),
      ),
    );
  }
}

///Service Category Type
class _ServiceCategory extends StatelessWidget {
  const _ServiceCategory({
    required this.controller,
    required this.ref,
  });

  final PostServiceController controller;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final sport = ref.watch(postServiceControllerPr).selectedSport;
    final category = ref.watch(postServiceControllerPr).selectedCategory;

    return AnimatedCrossFade(
      duration: Sizes.duration,
      crossFadeState:
          sport.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: const SizedBox.shrink(),
      secondChild: FormFiledWidget(
        title: "Service Category",
        isRequired: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.spaceMed),
          child: Column(
            children: [
              ///Items
              Wrap(
                spacing: Sizes.spaceMed,
                runSpacing: Sizes.spaceMed,
                alignment: WrapAlignment.spaceBetween,
                children: List.generate(
                  controller.getCategoriesData.length,
                  (index) {
                    final item = controller.getCategoriesData[index];
                    bool isActive = category == item;

                    return ChoiceChip.elevated(
                      padding: Sizes.globalPadding,
                      labelStyle: TextStyle(
                        color: isActive ? AppColors.white : null,
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.normal,
                      ),
                      onSelected: (v) => ref
                          .read(postServiceControllerPr.notifier)
                          .updateSelectedCategory(item),
                      avatar: isActive
                          ? null
                          : const Icon(
                              Icons.games,
                              color: AppColors.black,
                            ),
                      label: Text(item),
                      selected: isActive,
                    );
                  },
                ),
              ),

              ///Validation
              _ValidationErrorMessage(
                  listenable: controller.categoryValidation),
            ],
          ),
        ),
      ),
    );
  }
}

///Service SubCategory Type
class _ServiceSubCategory extends StatelessWidget {
  const _ServiceSubCategory({
    required this.controller,
    required this.ref,
  });

  final PostServiceController controller;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final sport = ref.watch(postServiceControllerPr).selectedSport;
    final category = ref.watch(postServiceControllerPr).selectedCategory;
    final subCategory = ref.watch(postServiceControllerPr).selectedSubCategory;

    return AnimatedCrossFade(
      duration: Sizes.duration,
      crossFadeState: sport.isEmpty || category.isEmpty
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: const SizedBox.shrink(),
      secondChild: FormFiledWidget(
        title: "Service Sub-Category",
        isRequired: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.spaceMed),
          child: Column(
            children: [
              ///Items
              Wrap(
                spacing: Sizes.spaceMed,
                runSpacing: Sizes.spaceMed,
                alignment: WrapAlignment.spaceBetween,
                children: List.generate(
                  controller.getSubCategoriesData.length,
                  (index) {
                    final item = controller.getSubCategoriesData[index];
                    bool isActive = subCategory == item;

                    return ChoiceChip.elevated(
                      padding: Sizes.globalPadding,
                      labelStyle: TextStyle(
                        color: isActive ? AppColors.white : null,
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.normal,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onSelected: (v) => ref
                          .read(postServiceControllerPr.notifier)
                          .updateSelectedSubCategory(item),
                      avatar: isActive
                          ? null
                          : const Icon(
                              Icons.games,
                              color: AppColors.black,
                            ),
                      label: Text(item),
                      selected: isActive,
                    );
                  },
                ),
              ),

              ///Validation
              _ValidationErrorMessage(
                  listenable: controller.subCategoryValidation),
            ],
          ),
        ),
      ),
    );
  }
}

///Validation Error Message
class _ValidationErrorMessage extends StatelessWidget {
  const _ValidationErrorMessage({required this.listenable});

  final ValueNotifier<String> listenable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenable,
      builder: (BuildContext context, String value, Widget? child) {
        if (value.isEmpty) return const SizedBox.shrink();

        return ValidationErrorText(
          padding: EdgeInsets.zero,
          text: value,
        );
      },
    );
  }
}
