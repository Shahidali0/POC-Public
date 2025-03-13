import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyCupertinoPageScaffold(
      title: "Notifications",
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No New Notifications",
              style: TextStyle(
                fontSize: Sizes.fontSize20,
                fontWeight: FontWeight.bold,
                color: AppColors.appTheme,
              ),
            ),
            Text(
              "You dont have any new notification, Will notify you if you have any..Thanks",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Sizes.fontSize18,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
