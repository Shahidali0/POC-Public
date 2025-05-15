part of 'package:cricket_poc/Views/SportzHub/Components/my_service_details.dart';

class _MyServiceBookingsList extends StatelessWidget {
  const _MyServiceBookingsList({
    required this.bookingsJson,
    this.showButtons = false,
  });

  final List<BookingsJson> bookingsJson;
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    if (bookingsJson.isEmpty) {
      return const EmptyDataWidget(subTitle: Constants.emptyMyServicesBooking);
    }

    return ListView.separated(
      key: const PageStorageKey('_MyServiceBookingsList'),
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Sizes.space),
      itemCount: bookingsJson.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: showButtons ? 230 : 180,
          child: _CardWidget(
            booking: bookingsJson[index],
            showButtons: showButtons,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: Sizes.space),
    );
  }
}

///Request List
class _CardWidget extends ConsumerWidget {
  const _CardWidget({
    required this.booking,
    required this.showButtons,
  });

  final BookingsJson booking;
  final bool showButtons;

  ///Reject the Booking
  void _onReject({
    required BuildContext context,
    required SportzHubController controller,
  }) {
    controller.updateMyServiceBookingStatus(
      context: context,
      providerId: booking.providerId!,
      bookingId: booking.bookingId!,
      status: BookingStatus.cancel,
    );
    return;
  }

  ///Approve the Booking
  void _onAccept({
    required BuildContext context,
    required SportzHubController controller,
  }) {
    controller.updateMyServiceBookingStatus(
      context: context,
      providerId: booking.providerId!,
      bookingId: booking.bookingId!,
      status: BookingStatus.confirmed,
    );
    return;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(sportzHubControllerPr.notifier);
    final isLoading =
        ref.watch(sportzHubControllerPr).loadingId == booking.bookingId;

    return Card(
      margin: EdgeInsets.zero,
      child: LoadingOverlay(
        showPlatformLoader: true,
        isLoading: isLoading,
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
              const SizedBox(height: Sizes.space),

              ///Show Buttons
              if (showButtons) ...[
                Row(
                  children: [
                    ///Reject
                    Expanded(
                      child: CommonButton(
                        onPressed: () => _onReject(
                          context: context,
                          controller: controller,
                        ),
                        dense: true,
                        backgroundColor: AppColors.red,
                        iconData: CupertinoIcons.clear_thick,
                        text: "Reject",
                      ),
                    ),
                    const SizedBox(width: Sizes.space),

                    ///Accept
                    Expanded(
                      child: CommonButton(
                        onPressed: () => _onAccept(
                          context: context,
                          controller: controller,
                        ),
                        dense: true,
                        backgroundColor: AppColors.green,
                        iconData: CupertinoIcons.checkmark,
                        text: "Accept",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.space),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
