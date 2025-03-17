import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindServiceDetailsScreen extends StatelessWidget {
  const FindServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCupertinoPageScaffold(
      previousPageTitle: "Home",
      title: "Elite Match Organization",

      ///Bottom Navbar
      bottomNavBar: const _BookNowButton(),

      ///Body
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ///About the Provider
          ..._aboutProvider(),

          const Divider(),

          ///Description
          ..._description(),

          ///What's Included
          ..._whatsIncluded(),

          ///Available Session Dates
          ..._availableSessionDates(),

          ///Location Details
          ..._locationDetails(),
        ],
      ),
    );
  }

  ///About the Provider
  List<Widget> _aboutProvider() => [
        ///Profile
        const ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.spaceMed,
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.blueLight,
            child: Text(
              "PS",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          title: Text(
            "Premium Cricket Solutions",
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Tag
              Flexible(
                child: Text(
                  "Match Organizer",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    // fontSize: Sizes.fontSize12,
                    color: AppColors.appTheme,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: Sizes.spaceSmall),

              ///Rating
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.orange,
                    ),
                    SizedBox(width: Sizes.spaceSmall),
                    Text("4.8 (24 reviews)"),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Sizes.spaceMed),

        ///Experience
        const Text(
          "10+ years organizing international matches",
          style: TextStyle(
            color: AppColors.black,
            fontSize: Sizes.fontSize16,
          ),
        ),

        const CustomTile(
          iconData: CupertinoIcons.person,
          text: "Member since Jan 2023",
        ),

        const CustomTile(
          iconData: CupertinoIcons.calendar,
          text: "2 available dates",
        ),

        const CustomTile(
          iconData: CupertinoIcons.map_pin_ellipse,
          text: "Melbourne Cricket Ground",
        ),

        const CustomTile(
          iconData: CupertinoIcons.timer,
          text: "180, 240 mins",
        ),
      ];

  ///Description Widget
  List<Widget> _description() => [
        // const SizedBox(height: Sizes.spaceHeight),
        const Text(
          "Description:",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: Sizes.fontSize18,
            color: AppColors.orange,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: Sizes.spaceMed),
        const Text(
          '''Premium match organization with top-tier grounds and professional umpires

Our Elite Match Organization service provides professional coaching tailored to your needs. Suitable for players of all ages and skill levels, from beginners to advanced players looking to refine their technique.

Book a session today and take your cricket skills to the next level!''',
          style: TextStyle(
            color: AppColors.black,
            fontSize: Sizes.fontSize16,
          ),
        ),
      ];

  ///What's Included
  List<Widget> _whatsIncluded() => [
        const SizedBox(height: Sizes.spaceHeight),
        const Text(
          "What's Included:",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: Sizes.fontSize18,
            color: AppColors.orange,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: Sizes.spaceMed),
        const Text(
          '''-- International standard ground
-- ICC certified umpires
-- Electronic scoreboard
-- Live streaming setup
-- Post-match analytics''',
          style: TextStyle(
            color: AppColors.black,
            fontSize: Sizes.fontSize16,
          ),
        ),
      ];

  ///Available Session Dates
  List<Widget> _availableSessionDates() => [
        const SizedBox(height: Sizes.spaceHeight),
        const Text(
          "Available Session Dates:",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: Sizes.fontSize18,
            color: AppColors.orange,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: Sizes.spaceMed),
        const Wrap(
          spacing: Sizes.space,
          children: [
            Chip(
              label: Text("Mar 20, 2024"),
            ),
            Chip(
              label: Text("Mar 22, 2024"),
            ),
          ],
        ),
      ];

  ///Location Details
  List<Widget> _locationDetails() => [
        const SizedBox(height: Sizes.spaceHeight),
        const Text(
          "Location Details:",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: Sizes.fontSize18,
            color: AppColors.orange,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: Sizes.spaceMed),
        SizedBox(
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(Sizes.borderRadius),
            ),
            child: const Icon(Icons.location_on_outlined),
          ),
        ),
        const SizedBox(height: Sizes.spaceMed),
        const Text(
          'This service is available at Melbourne Cricket Ground. Exact location details will be provided after booking confirmation.',
          style: TextStyle(
            color: AppColors.black,
            fontSize: Sizes.fontSize16,
          ),
        ),
      ];
}

///Book Now Button Widget
class _BookNowButton extends ConsumerWidget {
  const _BookNowButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.zero,
      child: SafeArea(
        minimum: Sizes.globalMargin,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Cost
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Per Session:",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "💲360",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.fontSize18,
                      color: AppColors.orange,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Sizes.spaceHeight),

            ///Button
            Expanded(
              flex: 2,
              child: CommonButton(
                onPressed: () =>
                    LogHelper.instance.showPlatformSpecificBottomSheet(
                  title: "Book Now",
                  context: context,
                  child: const BookServiceForm(),
                ),
                text: "Book Now",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
