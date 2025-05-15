import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'Components/service_components.dart';

class ServiceDetailsScreen extends ConsumerWidget {
  const ServiceDetailsScreen({
    super.key,
    required this.serviceJson,
  });

  final ServiceJson serviceJson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(serviceDetailsControllerPr).loading;

    bool disableButton = ref
        .read(serviceDetailsControllerPr.notifier)
        .isSameUserService(serviceJson.providerId);

    return LoadingOverlay(
      isLoading: isLoading,
      child: MyCupertinoSliverScaffold(
        previousPageTitle: "Home",
        title: "Service Details",

        ///Bottom Navbar
        bottomNavBar: _BookNowButton(
          serviceJson: serviceJson,
          ref: ref,
          disableButton: disableButton,
        ),

        ///Body
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            ///About the Provider
            ServiceProviderWidget(serviceJson: serviceJson),

            const Divider(),

            ///Description
            _DescriptionWidget(serviceJson: serviceJson),

            // ///Available Session Dates
            // _AvailableDatesWidget(serviceJson: serviceJson),

            // ///Available Session TimeSlots
            // _AvailableTimeSlotsWidget(serviceJson: serviceJson),

            ///Location Details
            ..._locationDetails(),
            // const SizedBox(height: Sizes.spaceHeight),

            ///Dates
            AbsorbPointer(
              absorbing: disableButton,
              child: _DatePickerField(
                dates: serviceJson.timeSlots!.keys.toList(),
              ),
            ),

            ///Time Slots
            AbsorbPointer(
              absorbing: disableButton,
              child: _TimeSlotsField(
                timeSlotsData: serviceJson.timeSlots!.values.first,
              ),
            ),

            ///Duration
            AbsorbPointer(
              absorbing: disableButton,
              child: _DurationField(
                sessionDurations: serviceJson.duration!,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        Text(
          'This service is available at ${serviceJson.location}. Exact location details will be provided after booking confirmation.',
          style: const TextStyle(
            color: AppColors.black,
            fontSize: Sizes.fontSize16,
          ),
        ),
      ];
}

///Service Provider Details Widget
class ServiceProviderWidget extends ConsumerWidget {
  const ServiceProviderWidget({
    super.key,
    required this.serviceJson,
    this.trailing,
    this.showOnlyProfile = false,
  });

  final ServiceJson serviceJson;
  final Widget? trailing;
  final bool showOnlyProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Profile
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.spaceMed,
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.lightBlue,
            child: Text(
              ref
                  .read(findServicesControllerPr.notifier)
                  .getInitials(serviceJson.title!),
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          title: Text(
            serviceJson.title!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: Sizes.fontSize18,
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: Text(
            "${serviceJson.category} (${serviceJson.sport})",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.orange,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: trailing,
        ),
        const SizedBox(height: Sizes.spaceMed),

        ///IIf Selected to show only profile then skip this
        if (!showOnlyProfile) ...[
          ///Member Since
          CustomListTile(
            iconSize: 22,
            fontSize: Sizes.fontSize16,
            maxLines: 4,
            iconData: CupertinoIcons.person,
            text:
                "Member since ${serviceJson.createdAt.formatDateToYMMMFormat}",
          ),
          const SizedBox(height: Sizes.spaceMed),

          ///TimeSlots
          CustomListTile(
            iconSize: 22,
            fontSize: Sizes.fontSize16,
            maxLines: 4,
            iconData: CupertinoIcons.calendar,
            text: "${serviceJson.timeSlots!.length} available date's",
          ),
          const SizedBox(height: Sizes.spaceMed),

          ///Location
          CustomListTile(
            iconSize: 22,
            fontSize: Sizes.fontSize16,
            maxLines: 4,
            iconData: CupertinoIcons.map_pin_ellipse,
            text: serviceJson.location!,
          ),
          const SizedBox(height: Sizes.spaceMed),

          ///Duration
          CustomListTile(
            iconSize: 22,
            fontSize: Sizes.fontSize16,
            maxLines: 4,
            iconData: CupertinoIcons.timer,
            text: serviceJson.duration.getDuration,
          ),
          const SizedBox(height: Sizes.spaceMed),
        ],
      ],
    );
  }
}

///Service Description Widget
class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    required this.serviceJson,
  });

  final ServiceJson serviceJson;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Sizes.spaceMed),
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
      ],
    );
  }
}

// ///Service Dates Widget
// class _AvailableDatesWidget extends StatelessWidget {
//   const _AvailableDatesWidget({
//     required this.serviceJson,
//   });

//   final ServiceJson serviceJson;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: Sizes.space),
//         const Text(
//           "Available Session Dates:",
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             fontSize: Sizes.fontSize18,
//             color: AppColors.black,
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         const SizedBox(height: Sizes.spaceMed),

//         ///Dates List
//         Wrap(
//           spacing: Sizes.space,
//           runSpacing: Sizes.space,
//           children: serviceJson.timeSlots!.entries.map(
//             (entry) {
//               return Card(
//                 elevation: 2,
//                 margin: EdgeInsets.zero,
//                 child: Padding(
//                   padding: Sizes.cardPadding,
//                   child: Text(entry.key),
//                 ),
//               );
//             },
//           ).toList(),
//         ),

//         const SizedBox(height: Sizes.spaceMed),
//       ],
//     );
//   }
// }

// ///Service Time Slots Widget
// class _AvailableTimeSlotsWidget extends StatelessWidget {
//   const _AvailableTimeSlotsWidget({
//     required this.serviceJson,
//   });

//   final ServiceJson serviceJson;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: Sizes.space),
//         const Text(
//           "Available Time Slots:",
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             fontSize: Sizes.fontSize18,
//             color: AppColors.black,
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         const SizedBox(height: Sizes.spaceMed),

//         ///TimeSlots List
//         Wrap(
//           spacing: Sizes.space,
//           runSpacing: Sizes.space,
//           children: serviceJson.timeSlots!.values.first.map(
//             (entry) {
//               return Card(
//                 elevation: 2,
//                 margin: EdgeInsets.zero,
//                 child: Padding(
//                   padding: Sizes.cardPadding,
//                   child: Text(entry),
//                 ),
//               );
//             },
//           ).toList(),
//         ),
//         const SizedBox(height: Sizes.spaceMed),
//       ],
//     );
//   }
// }

///Book Now Button Widget
class _BookNowButton extends StatelessWidget {
  const _BookNowButton({
    required this.serviceJson,
    required this.ref,
    required this.disableButton,
  });

  final ServiceJson serviceJson;
  final WidgetRef ref;
  final bool disableButton;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(serviceDetailsControllerPr);

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

            ///Continue Button
            Expanded(
              flex: 2,
              child: CommonButton(
                onPressed: state.selectedDate.isEmpty ||
                        state.selectedTimeSlot.isEmpty ||
                        state.selectedSessionDuration.isEmpty ||
                        disableButton
                    ? null
                    : () => ref
                        .read(serviceDetailsControllerPr.notifier)
                        .createBooking(
                          context: context,
                          serviceJson: serviceJson,
                        ),
                text: "Book Now",
              ),
            ),

            // Expanded(
            //   flex: 2,
            //   child: CommonButton(
            //     onPressed: disableButton
            //         ? null
            //         : () => ref.read(profileControllerPr.notifier).isAuthorized(
            //               context: context,
            //               redirectTo: () => AppRouter.instance.push(
            //                 context: context,
            //                 page: BookServiceScreen(serviceJson: serviceJson),
            //               ),
            //             ),
            //     text: "Book Now",
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
