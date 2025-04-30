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
            leadingText: "FullName: ",
            title: "${userJson.firstName} ${userJson.lastName}",
            leadingIcon: CupertinoIcons.person,
          ),

          ///Email
          _CustomTile(
            leadingText: "Email: ",
            title: userJson.username ?? "--",
            leadingIcon: CupertinoIcons.mail,
          ),

          ///Goal
          _CustomTile(
            leadingText: "Main Goal: ",
            title: userJson.goal ?? "--",
            leadingIcon: CupertinoIcons.bolt,
          ),

          ///UserType
          _CustomTile(
            leadingText: "User Type: ",
            title: "${userJson.userType}",
            leadingIcon: CupertinoIcons.person_2,
          ),

          ///Suburb
          _CustomTile(
            leadingText: "Suburb: ",
            title: userJson.suburb ?? "--",
            leadingIcon: CupertinoIcons.location,
          ),

          ///ABN
          _CustomTile(
            leadingText: "ABN: ",
            title: userJson.abn ?? "--",
            leadingIcon: CupertinoIcons.building_2_fill,
          ),

          const SizedBox(height: Sizes.spaceHeight * 2),
        ],
      ),
    );
  }
}

///Custom Tile
class _CustomTile extends StatelessWidget {
  const _CustomTile({
    required this.leadingText,
    required this.title,
    required this.leadingIcon,
  });

  final String leadingText;
  final String title;
  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(leadingIcon),
      title: RichText(
        text: TextSpan(
          text: leadingText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: Sizes.fontSize18,
              ),
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
