import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return const MyCupertinoSliverScaffold(
      title: "Change Password",
      body: SizedBox(),
    );
  }
}
