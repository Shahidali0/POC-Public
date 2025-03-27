import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PricingForm extends ConsumerWidget {
  const PricingForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(postServiceControllerPr.notifier);

    return Form(
      key: controller.pricingFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pricing",
            style: TextStyle(
              fontSize: Sizes.fontSize18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const Text("Set your pricing information"),
          const SizedBox(height: Sizes.spaceSmall),
          _ServicePriceField(controller: controller.priceController),
          const SizedBox(height: Sizes.spaceHeight),
        ],
      ),
    );
  }
}

///Service Price Field
class _ServicePriceField extends StatelessWidget {
  const _ServicePriceField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormFiledWidget(
      title: "Service Price (AUD)",
      isRequired: true,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        validator: FieldValidators.instance.commonValidator,
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
          ...Formatter.instance.digitsInputFormatter,
        ],
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          prefixIcon: Icon(CupertinoIcons.money_dollar),
          hintText: "e.g., 50",
        ),
      ),
    );
  }
}
