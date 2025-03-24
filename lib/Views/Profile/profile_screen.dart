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
      navigationBar: const CupertinoAppbar(title: "Profile"),
      child: ListView(
        padding: Sizes.cupertinoScaffoldPadding(context),
        children: [
          const Text(
            "ACCOUNT",
            style: TextStyle(
              fontSize: Sizes.fontSize18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Login/Create Account to manage orders",
            style: TextStyle(
              fontSize: Sizes.fontSize16,
            ),
          ),
          const SizedBox(height: Sizes.space),
          CommonButton(
            onPressed: () => AppRouter.instance.push(
              context: context,
              screen: const LoginScreen(),
            ),
            text: "Login",
          ),
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
