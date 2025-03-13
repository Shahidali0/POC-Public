import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

const _duration = Duration(milliseconds: 1200);

//* This screen is to show overlay loading animation for entire screen
class LoadingProgressBar extends StatelessWidget {
  const LoadingProgressBar({
    super.key,
    required this.child,
    required this.isLoading,
    this.opacity = 0.75,
  });

  final Widget child;
  final bool isLoading;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          _buildCenterWidget(context),
        ],
      ],
    );
  }

  Widget _buildCenterWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
          side: const BorderSide(color: AppColors.grey),
        ),
        child: const SizedBox(
          height: 85,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CustomCircleAnimation(
                size: 55.0,
                duration: _duration,
                color: null,
              ),
              SizedBox(width: Sizes.spaceHeightSm),
              Text(
                "Please wait...",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///Show MultiColor Loader
class ShowMultiColorLoader extends StatelessWidget {
  const ShowMultiColorLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CustomCircleAnimation(
      color: null,
      size: 60.0,
      duration: _duration,
    );
  }
}

//? Data Loader
class ShowDataLoader extends StatelessWidget {
  const ShowDataLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ShowMultiColorLoader(),
        const SizedBox(height: 3),
        Text(
          "Loading...",
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
        ),
      ],
    );
  }
}

//? Show Platform Loader
class ShowPlatformLoader extends StatelessWidget {
  const ShowPlatformLoader({
    super.key,
    this.radius = 30,
    this.color,
  });

  final double radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return SizedBox(
        height: radius,
        width: radius,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      );
    }
    return CupertinoActivityIndicator(
      radius: 14,
      color: color,
    );
  }
}

//* My Loader Animation
class _CustomCircleAnimation extends StatefulWidget {
  const _CustomCircleAnimation({
    required this.color,
    required this.size,
    required this.duration,
  });

  final Color? color;
  final double size;
  final Duration duration;

  @override
  State<_CustomCircleAnimation> createState() => _CustomCircleAnimationState();
}

class _CustomCircleAnimationState extends State<_CustomCircleAnimation>
    with SingleTickerProviderStateMixin {
  final List<double> delays = [
    .0,
    -1.1,
    -1.0,
    -0.9,
    -0.8,
    -0.7,
    -0.6,
    -0.5,
    -0.4,
    -0.3,
    -0.2,
    -0.1
  ];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Stack(
          children: List.generate(
            delays.length,
            (index) {
              final position = widget.size * .5;
              return Positioned.fill(
                left: position,
                top: position,
                child: Transform(
                  transform: Matrix4.rotationZ(30.0 * index * 0.0174533),
                  child: Align(
                    alignment: Alignment.center,
                    child: ScaleTransition(
                      scale: _DelayTween(
                              begin: 0.0, end: 1.0, delay: delays[index])
                          .animate(_controller),
                      child: SizedBox.fromSize(
                        size: Size.square(widget.size * 0.15),
                        child: _itemBuilder(index),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ///Circle Builder
  Widget _itemBuilder(int index) => DecoratedBox(
        decoration: BoxDecoration(
            color: widget.color ??
                AppColors.loadingColors[index % AppColors.loadingColors.length],
            shape: BoxShape.circle),
      );
}

///Delay Tween Widget
class _DelayTween extends Tween<double> {
  _DelayTween({super.begin, super.end, required this.delay});

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
