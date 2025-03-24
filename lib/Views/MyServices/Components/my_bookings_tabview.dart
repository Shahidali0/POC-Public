import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBookingsTabview extends StatelessWidget {
  const MyBookingsTabview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const PageStorageKey('MyBookingsTabview'),
      padding: Sizes.globalMargin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Bookings:",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Sizes.fontSize18,
                  color: AppColors.appTheme,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.appTheme,
                  decorationStyle: TextDecorationStyle.dashed,
                ),
              ),
              SizedBox(width: Sizes.spaceHeight),
              Flexible(child: _MyBookingSegments()),
            ],
          ),
          const SizedBox(height: Sizes.spaceHeightSm),

          ///List of Bookings
          Expanded(
            child: Consumer(
              builder: (_, WidgetRef ref, __) {
                final selectedSegment = ref.watch(myBookingSegemntIndexPr);

                return AnimatedSwitcher(
                  duration: Sizes.duration,
                  child: selectedSegment == MyBookingType.upcoming
                      ? const _UpcomingBookingsCard()
                      : const _PastBookingsCard(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

///myBooking Tabs
class _MyBookingSegments extends ConsumerWidget {
  const _MyBookingSegments();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSegment = ref.watch(myBookingSegemntIndexPr);

    return CupertinoSlidingSegmentedControl<MyBookingType>(
      groupValue: selectedSegment,
      thumbColor: AppColors.orange,
      padding: const EdgeInsets.all(Sizes.spaceMed),
      children: <MyBookingType, Widget>{
        ///UpComing
        MyBookingType.upcoming: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.space,
            vertical: Sizes.spaceMed,
          ),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: selectedSegment == MyBookingType.upcoming
                    ? AppColors.white
                    : null,
                size: Sizes.fontSize12,
              ),
              const SizedBox(width: Sizes.space),
              Text(
                "UpComing",
                style: TextStyle(
                  fontSize: Sizes.fontSize12,
                  color: selectedSegment == MyBookingType.upcoming
                      ? AppColors.white
                      : null,
                  fontWeight: selectedSegment == MyBookingType.upcoming
                      ? FontWeight.w800
                      : null,
                ),
              )
            ],
          ),
        ),

        ///Past
        MyBookingType.past: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.space,
            vertical: Sizes.spaceMed,
          ),
          child: Row(
            children: [
              Icon(
                Icons.history,
                color: selectedSegment == MyBookingType.past
                    ? AppColors.white
                    : null,
                size: Sizes.fontSize12,
              ),
              const SizedBox(width: Sizes.space),
              Text(
                "Past",
                style: TextStyle(
                  fontSize: Sizes.fontSize12,
                  color: selectedSegment == MyBookingType.past
                      ? AppColors.white
                      : null,
                  fontWeight: selectedSegment == MyBookingType.past
                      ? FontWeight.w800
                      : null,
                ),
              ),
            ],
          ),
        ),
      },
      onValueChanged: (MyBookingType? value) {
        if (value == null) return;

        ///Update Segment data
        ref
            .read(myBookingSegemntIndexPr.notifier)
            .update((state) => state = value);
      },
    );
  }
}
// class _MyBookingSegments extends ConsumerWidget {
//   const _MyBookingSegments();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedSegment = ref.watch(myBookingSegemntIndexPr);

//     return CupertinoSlidingSegmentedControl<MyBookingType>(
//       groupValue: selectedSegment,
//       thumbColor: AppColors.orange,
//       children: <MyBookingType, Widget>{
//         ///UpComing
//         MyBookingType.upcoming: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: Sizes.space,
//             vertical: Sizes.spaceMed,
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 CupertinoIcons.calendar,
//                 color: selectedSegment == MyBookingType.upcoming
//                     ? AppColors.white
//                     : null,
//                 size: Sizes.fontSize12,
//               ),
//               const SizedBox(width: Sizes.space),
//               Text(
//                 "UpComing",
//                 style: TextStyle(
//                   fontSize: Sizes.fontSize12,
//                   color: selectedSegment == MyBookingType.upcoming
//                       ? AppColors.white
//                       : null,
//                   fontWeight: selectedSegment == MyBookingType.upcoming
//                       ? FontWeight.w800
//                       : null,
//                 ),
//               )
//             ],
//           ),
//         ),

//         ///Past
//         MyBookingType.past: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: Sizes.space,
//             vertical: Sizes.spaceMed,
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.history,
//                 color: selectedSegment == MyBookingType.past
//                     ? AppColors.white
//                     : null,
//                 size: Sizes.fontSize12,
//               ),
//               const SizedBox(width: Sizes.space),
//               Text(
//                 "Past",
//                 style: TextStyle(
//                   fontSize: Sizes.fontSize12,
//                   color: selectedSegment == MyBookingType.past
//                       ? AppColors.white
//                       : null,
//                   fontWeight: selectedSegment == MyBookingType.past
//                       ? FontWeight.w800
//                       : null,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       },
//       onValueChanged: (MyBookingType? value) {
//         if (value == null) return;

//         ///Update Segment data
//         ref
//             .read(myBookingSegemntIndexPr.notifier)
//             .update((state) => state = value);
//       },
//     );
//   }
// }

///Upcoming Bookings Card
class _UpcomingBookingsCard extends StatelessWidget {
  const _UpcomingBookingsCard();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: Sizes.space),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return _buildCard();
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: Sizes.spaceHeight),
    );
  }

  //  ///Upcoming Card
  //             Align(
  //               alignment: Alignment.topRight,
  //   child: Card(
  //     margin: EdgeInsets.all(Sizes.spaceSmall),
  //     color: AppColors.orange,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(
  //         vertical: Sizes.spaceSmall,
  //         horizontal: Sizes.space,
  //       ),
  //       child: Text(
  //         "Upcoming",
  //         style: TextStyle(color: AppColors.white),
  //       ),
  //     ),
  //   ),
  // ),

  ///Card Widget
  Widget _buildCard() => Banner(
        color: AppColors.orange,
        message: "Upcoming",
        location: BannerLocation.topEnd,
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: Sizes.globalMargin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Header
                const Text(
                  "Professional Batting Practice",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Sizes.fontSize18,
                    color: AppColors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                ///Customer Name
                const Text(
                  "Customer: Alex Johnson",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: Sizes.fontSize16,
                  ),
                ),
                const SizedBox(height: Sizes.spaceSmall),

                ///Date
                const CustomTile(
                  iconData: CupertinoIcons.calendar,
                  text: "March 20, 2024",
                ),

                ///Time
                const CustomTile(
                  iconData: CupertinoIcons.time,
                  text: "09:00 AM",
                ),

                const SizedBox(height: Sizes.spaceSmall),
                CommonOutlineButton(
                  onPressed: () {},
                  text: "Send Reminder",
                  dense: true,
                ),
              ],
            ),
          ),
        ),
      );
}

///Past Bookings Card
class _PastBookingsCard extends StatelessWidget {
  const _PastBookingsCard();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: Sizes.space),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return buildCard();
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: Sizes.spaceHeight),
    );
  }

  //  ///Upcoming Card
  //             Align(
  //               alignment: Alignment.topRight,
  //   child: Card(
  //     margin: EdgeInsets.all(Sizes.spaceSmall),
  //     color: AppColors.orange,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(
  //         vertical: Sizes.spaceSmall,
  //         horizontal: Sizes.space,
  //       ),
  //       child: Text(
  //         "Upcoming",
  //         style: TextStyle(color: AppColors.white),
  //       ),
  //     ),
  //   ),
  // ),

  ///Card Widget
  Widget buildCard() => const Banner(
        color: AppColors.green,
        message: "Completed",
        location: BannerLocation.topEnd,
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: Sizes.globalMargin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Header
                Text(
                  "Professional Batting Practice",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Sizes.fontSize18,
                    color: AppColors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                ///Customer Name
                Text(
                  "Customer: Jamie Lee",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: Sizes.fontSize16,
                  ),
                ),
                SizedBox(height: Sizes.spaceSmall),

                ///Date
                CustomTile(
                  iconData: CupertinoIcons.calendar,
                  text: "March 20, 2024",
                ),

                ///Time
                CustomTile(
                  iconData: CupertinoIcons.time,
                  text: "09:00 AM",
                ),
              ],
            ),
          ),
        ),
      );
}
