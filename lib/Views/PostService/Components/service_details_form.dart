import 'package:cricket_poc/lib_exports.dart';
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
          _ServiceTitleField(controller: controller.serviceTitleController),
          _ServiceCategoryField(
            selectedServiceCategory: controller.selectedServiceCategory,
            onChanged: controller.handleServiceCategoryChanged,
          ),
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

///Service Category Type
class _ServiceCategoryField extends StatelessWidget {
  const _ServiceCategoryField({
    required this.selectedServiceCategory,
    required this.onChanged,
  });

  final ValueNotifier<String?> selectedServiceCategory;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedServiceCategory,
      builder: (BuildContext context, String? value, Widget? child) {
        return FormFiledWidget(
          title: "Service Category",
          isRequired: true,
          child: DropdownButtonFormField<String>(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            isExpanded: true,
            value: value,
            validator: FieldValidators.instance.commonValidator,
            items: [
              const DropdownMenuItem<String>(
                child: Text(
                  "Select a category",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.blueGrey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ...serviceCategoriesData.map((String valueItem) {
                return DropdownMenuItem<String>(
                  value: valueItem,
                  child: Text(
                    valueItem,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.blueGrey,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                );
              }),
            ],
            onChanged: onChanged,
            decoration: const InputDecoration(hintText: "Select a category"),
          ),
        );
      },
    );
  }
}
