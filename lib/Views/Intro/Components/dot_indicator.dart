import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => _buildDot(
          context: context,
          index: index,
        ),
      ),
    );
  }

  ///Dot Widget
  Widget _buildDot({
    required BuildContext context,
    required int index,
  }) {
    return AnimatedContainer(
      duration: Sizes.duration,
      width: index == currentIndex ? 20 : 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: Sizes.spaceSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        color: index == currentIndex ? AppColors.appTheme : AppColors.blueGrey,
      ),
    );
  }
}
