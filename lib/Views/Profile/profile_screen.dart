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
          _UserProfile(
            ref: ref,
          ),

          ///Divider
          const Divider(thickness: 5),

          ///AboutUs
          const ListTile(
            // onTap: () => AppRouter.instance.push(
            //   context: context,
            //   page: const AboutUsPage(),
            // ),
            leading: Icon(CupertinoIcons.info),
            title: Text("About Us"),
            trailing: Icon(Icons.chevron_right),
          ),

          ///Logout
          ListTile(
            onTap: () => ref.read(profileControllerPr.notifier).logout(context),
            textColor: AppColors.red,
            iconColor: AppColors.red,
            leading: const Icon(CupertinoIcons.arrow_right_circle),
            title: const Text("Logout"),
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
    UserJson? userJson = ref.read(userJsonPr)?.user;

    if (userJson == null) return const SizedBox.shrink();

    return ListTile(
      onTap: () => AppRouter.instance.push(
        context: context,
        page: ProfileDetailsPage(userJson: userJson),
      ),
      minLeadingWidth: 0,

      // contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.space),
      leading: CircleAvatar(
        radius: Sizes.space * 2,
        backgroundColor: AppColors.lightBlue,
        child: Text(
          "${userJson.firstName![0]}${userJson.lastName![0]}",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.white,
              ),
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
