//* EmptyList Widget
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    this.widget,
    this.subTitle,
    this.padding,
  });

  final Widget? widget;
  final String? subTitle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding,
      children: [
        Image.asset(
          AppImages.personRunningLogo,
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
          child: Text(
            subTitle ?? "Currently you don't have any data..",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.black,
                  fontSize: Sizes.fontSize18,
                ),
          ),
        ),
        if (widget != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: widget!,
          ),
          // CommonOutlineButton(
          //   minButtonWidth: 40,
          //   dense: true,
          //   onPressed: onRefresh,
          //   text: 'Refresh',
          // )
        ],
      ],
    );
  }
}
