import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBookingsTabviewPage extends ConsumerWidget {
  const MyBookingsTabviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(getMyBookingsFtPr.future),
      child: ref.watch(getMyBookingsFtPr).when(
            data: (data) {
              ///For Empty Services List
              if (data.isEmpty) {
                return const EmptyDataWidget(
                  subTitle: Constants.emmptyMyBookings,
                );
              }

              ///Data not empty
              return _body(
                context: context,
                myBookings: data,
                ref: ref,
              );
            },
            error: (e, st) {
              final error = e as Failure;
              return ErrorText(
                title: error.title,
                error: error.message,
                onRefresh: () async => ref.invalidate(getMyBookingsFtPr),
              );
            },
            loading: () => const ShowDataLoader(),
          ),
    );
  }

  ///Body Widget
  Widget _body({
    required List<BookingsJson> myBookings,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    final selectedSegment = ref.watch(myBookingSegemntIndexPr);

    ///UpComing Booking
    final upComing = myBookings
        .where(
          (item) =>
              item.status!.toLowerCase().contains(BookingStatus.pending.name) &&
              item.status!.toLowerCase().contains(BookingStatus.confirmed.name),
        )
        .toList();

    ///Past Booking
    final past = myBookings
        .where(
          (item) =>
              !item.status!
                  .toLowerCase()
                  .contains(BookingStatus.pending.name) &&
              !item.status!
                  .toLowerCase()
                  .contains(BookingStatus.confirmed.name),
        )
        .toList();

    return Padding(
      key: const PageStorageKey('MyBookingsTabview'),
      padding: Sizes.globalMargin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///My Bookings Segments
          const _MyBookingSegments(),

          const SizedBox(height: Sizes.spaceSmall),

          ///List of Bookings
          Expanded(
            child: AnimatedCrossFade(
              duration: Sizes.duration,

              ///UpComing Bookings List
              firstChild: _BookingListView(
                sendReminder: true,
                emptyBookingText: Constants.emmptyUpcomingBookings,
                bookings: upComing,
              ),

              ///Past Bookings List
              secondChild: _BookingListView(
                sendReminder: false,
                emptyBookingText: Constants.emmptyPastBookings,
                bookings: past,
              ),
              crossFadeState: selectedSegment == MyBookingType.upcoming
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
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
      thumbColor: AppColors.blueGrey,
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
                // size: Sizes.fontSize18,
              ),
              const SizedBox(width: Sizes.space),
              Text(
                "UpComing",
                style: TextStyle(
                  // fontSize: Sizes.fontSize12,
                  color: selectedSegment == MyBookingType.upcoming
                      ? AppColors.white
                      : null,
                  fontWeight: selectedSegment == MyBookingType.upcoming
                      ? FontWeight.bold
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
                // size: Sizes.fontSize18,
              ),
              const SizedBox(width: Sizes.space),
              Text(
                "Past",
                style: TextStyle(
                  // fontSize: Sizes.fontSize12,
                  color: selectedSegment == MyBookingType.past
                      ? AppColors.white
                      : null,
                  fontWeight: selectedSegment == MyBookingType.past
                      ? FontWeight.bold
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
    required this.emptyBookingText,
  });

  final List<BookingsJson> bookings;
  final bool sendReminder;
  final String emptyBookingText;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return EmptyDataWidget(subTitle: emptyBookingText);
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
          sendReminder: sendReminder,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: Sizes.spaceHeight),
    );
  }
}

///Booking Card Widget
class _BookingCard extends ConsumerWidget {
  const _BookingCard({
    required this.booking,
    required this.sendReminder,
  });

  final BookingsJson booking;
  final bool sendReminder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(sportzHubControllerPr.notifier);
    final loading = ref.watch(sportzHubControllerPr) == booking.bookingId!;

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
                Expanded(
                  child: Text(
                    booking.serviceTitle ?? "Service",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: Sizes.fontSize18,
                      color: AppColors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                const SizedBox(width: Sizes.spaceMed),

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
            Text(
              "Customer: ${booking.providerName ?? "N/A"}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: Sizes.fontSize16,
              ),
            ),
            const SizedBox(height: Sizes.spaceMed),

            ///Date
            CustomListTile(
              iconData: CupertinoIcons.calendar,
              text: booking.date.formatDateToString,
            ),

            ///Time
            CustomListTile(
              iconData: CupertinoIcons.time,
              text: booking.timeSlot!,
            ),

            ///Status
            CustomListTile(
              iconData: CupertinoIcons.info,
              text: booking.status!.capitalizeFirst,
              textColor: booking.status!.getStatusColor,
              fontWeight: FontWeight.w600,
            ),

            if (!sendReminder) const SizedBox(height: Sizes.space),

            ///Send Reminder Button and Delete Button
            if (sendReminder)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ///Send Reminder Button
                  Expanded(
                    child: CommonOutlineButton(
                      onPressed: () {
                        showSuccessSnackBar(
                          context: context,
                          content: "Feature coming soon",
                        );
                      },
                      text: "Send Reminder",
                      dense: true,
                    ),
                  ),
                  const SizedBox(width: Sizes.space),

                  ///Delete Button
                  CommonRectangleButton(
                    iconData: CupertinoIcons.trash,
                    loading: loading,
                    onPressed: () => controller.deleteBooking(
                      context: context,
                      bookingId: booking.bookingId!,
                      userId: booking.userId!,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
