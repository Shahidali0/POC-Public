import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBookingsTabview extends ConsumerWidget {
  const MyBookingsTabview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getMyBookingsPr).when(
          data: (data) {
            return RefreshIndicator.adaptive(
              onRefresh: () async => ref.invalidate(getMyBookingsPr),
              child: _body(
                context: context,
                myBookings: data,
                ref: ref,
              ),
            );
          },
          error: (e, st) {
            final error = e as Failure;
            return ErrorText(
              title: error.title,
              error: error.message,
            );
          },
          loading: () => const ShowDataLoader(),
        );
  }

  ///Body Widget
  Widget _body({
    required List<BookingsJson> myBookings,
    required WidgetRef ref,
    required BuildContext context,
  }) =>
      Padding(
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

                        ///UpComing Bookings List
                        ? _BookingListView(
                            sendReminder: true,
                            bookings: myBookings
                                .where((item) => item.status!
                                    .toLowerCase()
                                    .contains("pending"))
                                .toList(),
                          )
                        :

                        ///Past Bookings List
                        _BookingListView(
                            sendReminder: false,
                            bookings: myBookings
                                .where((item) => !item.status!
                                    .toLowerCase()
                                    .contains("pending"))
                                .toList(),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      );
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

/// Bookings List Card
class _BookingListView extends StatelessWidget {
  const _BookingListView({
    required this.bookings,
    required this.sendReminder,
  });

  final List<BookingsJson> bookings;
  final bool sendReminder;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return const EmptyDataWidget();
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        top: Sizes.space,
        bottom: Sizes.spaceHeight * 5,
      ),
      itemCount: bookings.length,
      itemBuilder: (BuildContext context, int index) {
        return _BookingCard(
          booking: bookings[index],
          status: bookings[index].status!,
          sendReminder: sendReminder,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: Sizes.spaceHeight),
    );
  }
}

///Booking Card Widget
class _BookingCard extends StatelessWidget {
  const _BookingCard({
    required this.booking,
    required this.status,
    required this.sendReminder,
  });

  final BookingsJson booking;
  final String status;
  final bool sendReminder;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: Sizes.globalMargin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Header
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Professional Batting Practice",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.fontSize18,
                      color: AppColors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                ///Price Tag
                Text(
                  "\$ ${booking.price}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: Sizes.fontSize16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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
            CustomTile(
              iconData: CupertinoIcons.calendar,
              text: Utils.instance.formatDateToString(booking.date),
            ),

            ///Time
            CustomTile(
              iconData: CupertinoIcons.time,
              text: booking.timeSlot!,
            ),

            ///Status
            CustomTile(
              iconData: CupertinoIcons.question_circle,
              text: status.capitalizeFirst,
              textColor: status.toLowerCase().contains("pending")
                  ? AppColors.orange
                  : AppColors.green,
              fontWeight: FontWeight.w600,
            ),

// ///Status
//                   const Text(
//                     "Pending",
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: Sizes.fontSize12,
//                       color: AppColors.green,
//                     ),
//                   ),

            const SizedBox(height: Sizes.spaceSmall),

            if (sendReminder) ...[
              CommonOutlineButton(
                onPressed: () {},
                text: "Send Reminder",
                dense: true,
              ),
              const SizedBox(height: Sizes.space),
            ]
          ],
        ),
      ),
    );
  }
}
