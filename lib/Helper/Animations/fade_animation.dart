import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

class FadeAnimations extends StatefulWidget {
  const FadeAnimations({
    super.key,
    required this.child,
    this.type = FadeAnimationType.bottomUp,
    this.from = 30,
    this.delay = 1,
  });

  final Widget child;
  final FadeAnimationType type;
  final double from;
  final double delay;

  @override
  State<FadeAnimations> createState() => _FadeAnimationsState();
}

class _FadeAnimationsState extends State<FadeAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool disposed = false;

  late Animation<double> animation;

  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: Sizes.duration, vsync: this);

    animation = Tween<double>(begin: widget.from, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.45)));

    ///Set Delay for Transition
    Future.delayed(Duration(milliseconds: (100 * widget.delay).round()), () {
      if (!disposed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: _getOffset(widget.type),
          child: AnimatedOpacity(
            duration: Sizes.duration,
            opacity: opacity.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  Offset _getOffset(FadeAnimationType type) {
    if (type == FadeAnimationType.leftToRight) {
      return Offset(-animation.value, 0);
    }
    if (type == FadeAnimationType.rightToLeft) {
      return Offset(animation.value, 0);
    }
    if (type == FadeAnimationType.upDown) {
      return Offset(0, -animation.value);
    }
    return Offset(0, animation.value);
  }
}
