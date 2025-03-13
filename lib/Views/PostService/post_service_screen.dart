import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class PostServiceScreen extends StatelessWidget {
  const PostServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyCupertinoPageScaffold(
      previousPageTitle: "Home",
      title: "Post Service",
      body: Center(
        child: Text("Under Progress"),
      ),
    );
  }
}

class BeautifulStepper extends StatefulWidget {
  const BeautifulStepper({super.key});

  @override
  _BeautifulStepperState createState() => _BeautifulStepperState();
}

class _BeautifulStepperState extends State<BeautifulStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
            child: Stepper(
              physics: const ScrollPhysics(),
              type: StepperType.horizontal, // Horizontal Stepper
              currentStep: _currentStep,
              onStepTapped: (step) => setState(() => _currentStep = step),
              onStepContinue: () {
                if (_currentStep < 2) {
                  setState(() => _currentStep += 1);
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() => _currentStep -= 1);
                }
              },
              steps: [
                _buildStep("Step 1", "Start", true),
                _buildStep("Step 2", "Verify", false),
                _buildStep("Step 3", "Finish", false),
              ],
              controlsBuilder: (context, details) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_currentStep > 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text("Back"),
                      ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(_currentStep == 2 ? "Finish" : "Next"),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Step ${_currentStep + 1} Content",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Step _buildStep(String title, String subtitle, bool isActive) {
    return Step(
      title: Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      content: Container(), // Empty as content is displayed below stepper
      isActive: isActive,
      state: isActive ? StepState.editing : StepState.indexed,
    );
  }
}
