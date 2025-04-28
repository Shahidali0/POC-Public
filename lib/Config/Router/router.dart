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
    required Widget page,
  }) {
    ///IOS
    if (Platform.isIOS) {
      return Navigator.of(context)
          .push(CupertinoPageRoute(builder: (ctx) => page));
    }

    ///ANDROID
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => page));
  }

  //* Animated Push syntax -> To navigate next screen
  Future<dynamic>? animatedPush({
    required BuildContext context,
    required Widget page,
    MyAnimationType type = MyAnimationType.bottomUp,
    bool scaleTransition = false,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            page,
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
    required Widget page,
  }) {
    ///IOS
    if (Platform.isIOS) {
      return Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (ctx) => page));
    }

    ///ANDROID
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => page));
  }

  //* PushOff syntax -> To navigate next screen and close previous screens
  Future<dynamic>? pushOff({
    required BuildContext context,
    required Widget page,
  }) {
    ///IOS
    if (Platform.isIOS) {
      return Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (ctx) => page),
        (Route<dynamic> route) => false,
      );
    }

    ///ANDROID
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => page),
      (Route<dynamic> route) => false,
    );
  }

  //* Pop syntax -> To go back to previous  screen
  void pop(BuildContext context, {dynamic result}) {
    return Navigator.of(context).pop(result);
  }

  //* Pop syntax -> To go back to First Screen
  void popUntil(BuildContext context) {
    return Navigator.of(context).popUntil((route) => route.isFirst);
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
