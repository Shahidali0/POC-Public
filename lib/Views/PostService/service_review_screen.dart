import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostServiceReviewScreen extends StatelessWidget {
  const PostServiceReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCupertinoSliverScaffold(
      title: "Post Service",
      bottomNavBar: SafeArea(
        minimum: Sizes.globalMargin,
        child: CommonButton(onPressed: () {}, text: "Post Service"),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Text(
            "Review & Submit",
            style: TextStyle(
              fontSize: Sizes.fontSize18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const Text("Review your service details before posting"),
          const SizedBox(height: Sizes.spaceHeight),

          ///Service Title
          const Text(
            "Professional Batting Practice",
            style: TextStyle(
              fontSize: Sizes.fontSize18,
              fontWeight: FontWeight.bold,
              color: AppColors.appTheme,
            ),
          ),

          ///Category Tag
          const Text(
            "(Coaching)",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              color: AppColors.orange,
            ),
          ),

          ///Location
          const ListTile(
            minVerticalPadding: 0,
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(CupertinoIcons.map_pin_ellipse),
            title: Text(
              "National Cricket Center",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: Sizes.fontSize16,
              ),
            ),
          ),
          const Divider(),

          ///Description
          const _VerticalTile(
            header: "Description",
            body:
                '''High-level batting coaching with former international player.Our Elite Batting Coaching service provides professional coaching tailored to your needs. Suitable for players of all ages and skill levels, from beginners to advanced players looking to refine their technique.

Book a session today and take your cricket skills to the next level!''',
          ),

          ///Duration and Price
          const Row(
            children: [
              Expanded(
                child: _VerticalTile(
                  header: "Duration",
                  body: " 180 min",
                  iconData: CupertinoIcons.timer,
                ),
              ),
              Expanded(
                child: _VerticalTile(
                  header: "Price",
                  body: "365",
                  iconData: CupertinoIcons.money_dollar,
                  bodyColor: AppColors.appTheme,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          ///Available Dates
          const SizedBox(height: Sizes.space),
          const Text(
            "Available Dates:",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.black,
              fontSize: Sizes.fontSize16,
            ),
          ),
          const SizedBox(height: Sizes.spaceMed),
          Wrap(
            spacing: Sizes.space,
            children: List.generate(
              4,
              (i) => const Chip(
                padding: EdgeInsets.symmetric(horizontal: Sizes.spaceHeight),
                shadowColor: AppColors.orange,
                side: BorderSide(color: AppColors.orange),
                avatar: Icon(
                  CupertinoIcons.calendar,
                  color: AppColors.orange,
                ),
                label: Text(
                  '29-07-2024',
                  style: TextStyle(
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ).toList(),
          ),

          ///Available TimeSlots
          const SizedBox(height: Sizes.space),
          const Text(
            "Available Times:",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.black,
              fontSize: Sizes.fontSize16,
            ),
          ),
          const SizedBox(height: Sizes.spaceMed),
          Wrap(
            spacing: Sizes.space,
            children: List.generate(
              4,
              (i) => const Chip(
                padding: EdgeInsets.symmetric(horizontal: Sizes.spaceHeight),
                shadowColor: AppColors.orange,
                side: BorderSide(color: AppColors.orange),
                avatar: Icon(
                  CupertinoIcons.time,
                  color: AppColors.orange,
                ),
                label: Text(
                  '10:00 Am',
                  style: TextStyle(
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ).toList(),
          )
        ],
      ),
    );
  }
}

///Custom Vertical Tile
class _VerticalTile extends StatelessWidget {
  const _VerticalTile({
    required this.header,
    required this.body,
    this.iconData,
    this.bodyColor = AppColors.black,
    this.fontWeight = FontWeight.normal,
  });

  final String header;
  final String body;
  final IconData? iconData;
  final Color bodyColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: Sizes.space),
        Text(
          "$header: ",
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.black,
            fontSize: Sizes.fontSize16,
          ),
        ),
        Flexible(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: Sizes.spaceMed,
            minTileHeight: 0,
            horizontalTitleGap: 3,
            dense: true,
            iconColor: bodyColor,
            textColor: bodyColor,
            leading: iconData != null ? Icon(iconData) : null,
            title: Text(
              body,
              style: TextStyle(
                fontSize: Sizes.fontSize16,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
