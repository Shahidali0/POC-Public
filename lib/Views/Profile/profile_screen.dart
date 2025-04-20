import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoAppbar(
        title: "Profile",
        showNotificationIcon: true,
      ),
      child: ListView(
        padding: Sizes.cupertinoScaffoldPadding(context),
        children: [
          ///User Profile
          AuthorizedWidget(
            child: _UserProfile(
              ref: ref,
            ),
          ),

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

///User Profile
//* If User is not authorized then show Authorize Widget
class _UserProfile extends StatelessWidget {
  const _UserProfile({
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    UserJson userJson = ref.read(userJsonPr)!.user!;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.space),
      leading: CircleAvatar(
        child: Text(
          "${userJson.firstName![0]}${userJson.lastName![0]}",
        ),
      ),
      title: Text(
        "${userJson.firstName} ${userJson.lastName}",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        userJson.username!,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
