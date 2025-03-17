import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class ServiceDetailsForm extends ConsumerStatefulWidget {
  const ServiceDetailsForm({super.key});

  @override
  ConsumerState<ServiceDetailsForm> createState() => _ServiceDetailsFormState();
}

class _ServiceDetailsFormState extends ConsumerState<ServiceDetailsForm> {
  late TextEditingController _serviceTitleController;
  late TextEditingController _serviceDescriptionController;
  late TextEditingController _serviceCategoryController;

  ValueNotifier<String?> _selectedServiceCategory = ValueNotifier(null);

  @override
  void initState() {
    _serviceTitleController = TextEditingController();
    _serviceDescriptionController = TextEditingController();
    _serviceCategoryController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _serviceTitleController.dispose();
    _serviceDescriptionController.dispose();
    _serviceCategoryController.dispose();
    super.dispose();
  }

  ///Service Category Update Function
  void _handleServiceCategoryChanged(String? value) {
    if (value == null) {
      _selectedServiceCategory = ValueNotifier(null);
      return;
    }

    _selectedServiceCategory = ValueNotifier(value);
    debugPrint("_selectedIdType:${_selectedServiceCategory.value}");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ref.read(postServiceControllerPr.notifier).serviceDetailsFormKey,
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
          _ServiceTitleField(controller: _serviceTitleController),
          _ServiceCategoryField(
            selectedServiceCategory: _selectedServiceCategory,
            onChanged: _handleServiceCategoryChanged,
          ),
          _ServiceDescriptionField(controller: _serviceDescriptionController),
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
            menuMaxHeight: 300,
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
              ...specializations.map((String valueItem) {
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
