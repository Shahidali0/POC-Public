import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class AppVersionText extends StatelessWidget {
  const AppVersionText({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final version = snapshot.data!.version;
        final buildNumber = snapshot.data!.buildNumber;

        return Text('App version: $version-$buildNumber');
      },
    );
  }
}
