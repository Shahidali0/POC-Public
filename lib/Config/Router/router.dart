import 'dart:io';

import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static AppRouter get instance => AppRouter._();

  //* Push syntax -> To navigate next screen
  Future<dynamic>? push({
    required BuildContext context,
    required Widget screen,
  }) {
    ///IOS
    if (Platform.isIOS) {
      return Navigator.of(context)
          .push(CupertinoPageRoute(builder: (ctx) => screen));
    }

    ///ANDROID
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => screen));
  }

  //* Animated Push syntax -> To navigate next screen
  Future<dynamic>? animatedPush({
    required BuildContext context,
    required Widget screen,
    MyAnimationType type = MyAnimationType.bottomUp,
    bool scaleTransition = false,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(begin: _getOffset(type), end: const Offset(0, 0))
                .animate(animation),
            child: scaleTransition
                ? ScaleTransition(
                    scale: animation,
                    child: child,
                  )
                : child,
          );
        },
      ),
    );
  }

  //* Push Replacement syntax -> To navigate next screen
  Future<dynamic>? pushReplacement({
    required BuildContext context,
    required Widget screen,
  }) {
    ///IOS
    if (Platform.isIOS) {
      return Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (ctx) => screen));
    }

    ///ANDROID
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => screen));
  }

  //* PushOff syntax -> To navigate next screen and close previous screens
  Future<dynamic>? pushOff({
    required BuildContext context,
    required Widget screen,
  }) {
    ///IOS
    if (Platform.isIOS) {
      return Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (ctx) => screen),
        (Route<dynamic> route) => false,
      );
    }

    ///ANDROID
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => screen),
      (Route<dynamic> route) => false,
    );
  }

  //* Pop syntax -> To go back to previous  screen
  void pop(BuildContext context, {dynamic result, bool rootNavigator = false}) {
    return Navigator.of(context, rootNavigator: rootNavigator).pop(result);
  }

  ///Get OffSet For PageTransition Animation
  Offset _getOffset(MyAnimationType type) {
    if (type == MyAnimationType.leftToRight) {
      return const Offset(-1, 0);
    }
    if (type == MyAnimationType.rightToLeft) {
      return const Offset(1, 0);
    }
    if (type == MyAnimationType.upDown) {
      return const Offset(0, -1);
    }
    return const Offset(0, 1);
  }
}
