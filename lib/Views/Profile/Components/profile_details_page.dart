import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key, required this.userJson});

  final UserJson userJson;

  @override
  Widget build(BuildContext context) {
    return MyCupertinoSliverScaffold(
      title: "UserProfile",
      body: Column(
        children: [
          ///FullName
          _CustomTile(
            title: "${userJson.firstName} ${userJson.lastName}",
            leadingIcon: CupertinoIcons.person,
          ),

          ///Email
          _CustomTile(
            title: userJson.username ?? "--",
            leadingIcon: CupertinoIcons.mail,
          ),

          ///Goal
          _CustomTile(
            title: userJson.goal ?? "--",
            leadingIcon: CupertinoIcons.bolt,
          ),

          ///UserType
          _CustomTile(
            title: userJson.userType ?? "--",
            leadingIcon: CupertinoIcons.person_2,
          ),

          ///Suburb
          _CustomTile(
            title: userJson.suburb ?? "--",
            leadingIcon: CupertinoIcons.location,
          ),

          ///ABN
          _CustomTile(
            title: "ABN: ${userJson.abn} ",
            leadingIcon: CupertinoIcons.building_2_fill,
          ),

          const SizedBox(height: Sizes.spaceHeight * 2),

          // ///Logout Button
          // Consumer(
          //   builder: (_, WidgetRef ref, __) {
          //     return CommonButton(
          //       onPressed: () =>
          //           ref.read(profileControllerPr.notifier).logout(context),
          //       text: "Logout",
          //       backgroundColor: AppColors.red,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

///Custom Tile
class _CustomTile extends StatelessWidget {
  const _CustomTile({
    required this.title,
    required this.leadingIcon,
  });

  final String title;
  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(leadingIcon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.fontSize18,
            ),
      ),
    );
  }
}
