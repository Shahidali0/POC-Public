import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _FindServicesScreenState();
}

class _FindServicesScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoAppbar(
        title: "Profile",
        showNotificationIcon: true,
      ),
      child: ListView(
        padding: Sizes.cupertinoScaffoldPadding(context),
        children: [
          const Authorize(),
          const SizedBox(height: Sizes.spaceMed),

          ///Divider
          const Divider(thickness: 5),

          ///AboutUs
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.info),
            title: const Text("About Us"),
            trailing: const Icon(Icons.chevron_right),
          ),

          ///Version
          const Center(
            child: Text("App version 1.0.0"),
          ),
        ],
      ),
    );
  }
}
