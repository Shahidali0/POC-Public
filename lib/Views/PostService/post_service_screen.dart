import 'dart:collection';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'Controller/post_service_controller.dart';
part 'Components/location_schedule_form.dart';
part 'Components/pricing_form.dart';
part 'Components/service_details_form.dart';

class PostServiceScreen extends ConsumerStatefulWidget {
  const PostServiceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostServiceScreenState();
}

class _PostServiceScreenState extends ConsumerState<PostServiceScreen> {
  late PostServiceController _controller;

  @override
  void initState() {
    _controller = ref.read(postServiceControllerPr.notifier);
    _controller.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(_stepperIndexPr);

    return MyCupertinoSliverScaffold(
      scrollController: _controller.scrollController,
      previousPageTitle: "Home",
      title: "Post Service",
      margin: EdgeInsets.zero,
      body: _controller.allCategories.isEmpty
          ? ErrorText(
              title: "Something went wrong",
              error: "Please try to refresh the page",
              onRefresh: _controller.loadAllCategories,
            )
          : AuthorizedWidget(
              child: Stepper(
                elevation: 0.7,
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepTapped: (step) => _controller.onStepTapped(
                  currentStep: currentStep,
                  step: step,
                ),
                onStepContinue: () => _controller.onStepContinue(
                  context: context,
                  currentStep: currentStep,
                ),
                onStepCancel: () => _controller.onStepCancel(currentStep),
                steps: [
                  ///Step1
                  _buildStep(
                    title: "Service\nDetails",
                    content: const _ServiceDetailsForm(),
                    isActive: currentStep == 0,
                    isCompleted: currentStep > 0,
                  ),

                  ///Step2
                  _buildStep(
                    title: "Location &\nSchedule",
                    content: const _LocationScheduleForm(),
                    isActive: currentStep == 1,
                    isCompleted: currentStep > 1,
                  ),

                  ///Step3
                  _buildStep(
                    title: "Pricing",
                    content: const _PricingForm(),
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
