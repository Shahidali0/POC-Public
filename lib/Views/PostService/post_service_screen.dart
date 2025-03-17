import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

part 'Controller/post_service_controller.dart';

class PostServiceScreen extends ConsumerWidget {
  const PostServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(_stepperIndexPr);

    return MyCupertinoPageScaffold(
      previousPageTitle: "Home",
      title: "Post Service",
      margin: EdgeInsets.zero,
      body: Stepper(
        elevation: 0.3,
        type: StepperType.horizontal,
        margin: EdgeInsets.zero,
        currentStep: currentStep,
        onStepTapped: (step) {
          if (currentStep > step) {
            ref.read(_stepperIndexPr.notifier).update((state) => state = step);
          }
        },
        onStepContinue: () {
          if (currentStep < 2) {
            ref.read(_stepperIndexPr.notifier).update((state) => state += 1);
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            ref.read(_stepperIndexPr.notifier).update((state) => state -= 1);
          }
        },
        steps: [
          ///Step1
          _buildStep(
            title: "Service\nDetails",
            content: const ServiceDetailsForm(),
            isActive: currentStep == 0,
            isCompleted: currentStep > 0,
          ),

          ///Step2
          _buildStep(
            title: "Location &\nSchedule",
            content: const LocationScheduleForm(),
            isActive: currentStep == 1,
            isCompleted: currentStep > 1,
          ),

          ///Step3
          _buildStep(
            title: "Pricing",
            content: const PricingForm(),
            isActive: currentStep == 2,
            isCompleted: currentStep > 2,
          ),
        ],
        controlsBuilder: (context, details) {
          return _StepperControlsButtons(
            currentStep: currentStep,
            details: details,
          );
        },
      ),
    );
  }

  ///Build Step Widget
  Step _buildStep({
    required String title,
    required Widget content,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Step(
      title: Text(
        title,
        style: TextStyle(
          fontSize: Sizes.defaultSize,
          fontWeight: FontWeight.bold,
          color: isCompleted ? AppColors.orange : null,
        ),
      ),
      content: content,
      isActive: isActive,
      state: isCompleted
          ? StepState.complete
          : (isActive ? StepState.editing : StepState.disabled),
      stepStyle: StepStyle(
        color: isCompleted ? AppColors.orange : null,
        connectorThickness: isCompleted ? 2 : 1,
      ),
    );
  }
}

///Stepper Controls -- Next and Back Button
class _StepperControlsButtons extends StatelessWidget {
  const _StepperControlsButtons({
    required this.currentStep,
    required this.details,
  });

  final int currentStep;
  final ControlsDetails details;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (currentStep > 0) ...[
          Expanded(
            child: CommonOutlineButton(
              onPressed: details.onStepCancel,
              text: "Previous",
            ),
          ),
          const SizedBox(width: Sizes.space),
        ],
        Expanded(
          child: CommonButton(
            onPressed: details.onStepContinue,
            text: currentStep == 2 ? "Review" : "Next",
          ),
        ),
      ],
    );
  }
}
