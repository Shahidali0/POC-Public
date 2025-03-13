import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

bool validateForm(GlobalKey<FormState> formKey) => _validate(formKey);

///Validate Form
///
bool _validate(GlobalKey<FormState> formKey) {
  if (formKey.currentState!.validate()) {
    return true;
  }
  return false;
}

///This is custom form field widget to show the header text followed by textform field
class FormFiledWidget extends StatelessWidget {
  const FormFiledWidget({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Sizes.space),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.black,
            fontSize: Sizes.fontSize16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: Sizes.spaceMed),
        child,
      ],
    );
  }
}
