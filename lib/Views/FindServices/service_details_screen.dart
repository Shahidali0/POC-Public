import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceDetailsScreen extends ConsumerWidget {
  const ServiceDetailsScreen({
    super.key,
    required this.serviceJson,
  });

  final ServiceJson serviceJson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(findServicesControllerPr.notifier);

    return MyCupertinoSliverScaffold(
      previousPageTitle: "Home",
      title: serviceJson.title!,

      ///Bottom Navbar
      bottomNavBar: _BookNowButton(serviceJson: serviceJson),

      ///Body
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ///About the Provider
          ..._aboutProvider(controller),

          const Divider(),

          ///Description
          ..._description(),

          ///What's Included
          ..._whatsIncluded(),

          ///Available Session Dates
          ..._availableSessionDates(),

          ///Location Details
          ..._locationDetails(),
          const SizedBox(height: Sizes.spaceHeight),
        ],
      ),
    );
  }

  ///About the Provider
  List<Widget> _aboutProvider(FindServciesController controller) => [
        ///Profile
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.spaceMed,
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.blueLight,
            child: Text(
              controller.getInitials(serviceJson.title!),
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          title: Text(serviceJson.title!),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Tag
              Flexible(
                child: Text(
                  serviceJson.category!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.appTheme,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Sizes.spaceMed),

        CustomTile(
          iconData: CupertinoIcons.person,
          text:
              "Member since ${Utils.instance.formatDateYMMM(serviceJson.createdAt)}",
        ),

        CustomTile(
          iconData: CupertinoIcons.calendar,
          text: "${serviceJson.timeSlots!.length} available dates",
        ),

        CustomTile(
          iconData: CupertinoIcons.map_pin_ellipse,
          text: serviceJson.location!,
        ),

        CustomTile(
          iconData: CupertinoIcons.timer,
          text: Utils.instance.getDuration(serviceJson.duration),
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
            color: AppColors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: Sizes.spaceMed),
        Text(
          serviceJson.description!,
          style: const TextStyle(
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
            color: AppColors.black,
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
            color: AppColors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: Sizes.spaceMed),
        Wrap(
          spacing: Sizes.space,
          children: serviceJson.timeSlots!.entries.map(
            (entry) {
              return Chip(label: Text(entry.key));
            },
          ).toList(),
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
            color: AppColors.black,
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
        Text(
          'This service is available at ${serviceJson.location}. Exact location details will be provided after booking confirmation.',
          style: const TextStyle(
            color: AppColors.black,
            fontSize: Sizes.fontSize16,
          ),
        ),
      ];
}

///Book Now Button Widget
class _BookNowButton extends ConsumerWidget {
  const _BookNowButton({required this.serviceJson});

  final ServiceJson serviceJson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.zero,
      child: SafeArea(
        minimum: Sizes.globalPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Cost
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Per Session:",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$ ${serviceJson.price}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: Sizes.fontSize18,
                      color: AppColors.black,
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
