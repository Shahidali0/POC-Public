import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  late Future<List<NotificationJson>> _futureData;

  @override
  void initState() {
    _futureData =
        ref.read(notificationControllerPr.notifier).getAllNotificationsList();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  ///Refresh Data
  void _refreshData() {
    setState(() {
      _futureData =
          ref.read(notificationControllerPr.notifier).getAllNotificationsList();
    });
  }

  ///onTap Notification
  void _onTapNotification({
    required NotificationJson notification,
    required bool isLoading,
  }) async {
    if (isLoading) return;

    final updated = await ref
        .read(notificationControllerPr.notifier)
        .updateNotificationStatus(
          context: context,
          bookingId: notification.bookingId!,
        );

    ///If notification updated then just simply refresh the notification
    if (updated) {
      notification.status = "read";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyCupertinoSliverScaffold(
      title: "Notifications",
      body: FutureBuilder<List<NotificationJson>>(
        future: _futureData,
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationJson>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const ShowDataLoader();

            case ConnectionState.done:
            default:
              //*If SnapData has error
              if (snapshot.hasError) {
                final error = snapshot.error as Failure;

                return ErrorText(
                  title: error.title,
                  error: error.message,
                  onRefresh: _refreshData,
                );
              }
              //*If SnapData is present
              else if (snapshot.hasData) {
                return _bodyView(
                  notifications: snapshot.data!,
                );
              }

              //*If No Data Available
              else {
                return const EmptyDataWidget(
                  subTitle: Constants.emptyNotification,
                );
              }
          }
        },
      ),
    );
  }

  ///BodyView
  Widget _bodyView({
    required List<NotificationJson> notifications,
  }) {
    if (notifications.isEmpty) {
      return const EmptyDataWidget(
        subTitle: Constants.emptyNotification,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: Sizes.spaceMed),
      itemCount: notifications.length,
      separatorBuilder: (ctx, i) => const SizedBox(height: Sizes.space),
      itemBuilder: (context, index) {
        final notification = notifications[index];

        return _notificationCard(
          notification: notification,
          context: context,
        );
      },
    );
  }

  ///Notification Card
  Widget _notificationCard({
    required NotificationJson notification,
    required BuildContext context,
  }) {
    bool isLoading =
        ref.watch(notificationControllerPr) == notification.bookingId;
    bool isUnread = notification.status!.toLowerCase().contains("unread");

    return GestureDetector(
      onTap: isUnread
          ? () => _onTapNotification(
                notification: notification,
                isLoading: isLoading,
              )
          : null,
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: Sizes.spaceMed,
            horizontal: Sizes.space,
          ),
          trailing: isLoading ? const ShowPlatformLoader() : null,
          leading: badges.Badge(
            position: badges.BadgePosition.custom(
              end: 30,
              bottom: 10,
            ),
            showBadge: isUnread ? true : false,
            child: const Icon(
              CupertinoIcons.bell,
              size: 30,
            ),
          ),
          title: Text(
            notification.eventType?.replaceAll("_", " ").capitalizeFirst ??
                "New Notification",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: AppTheme.boldFont,
                  fontSize: Sizes.fontSize18,
                ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ///Message
              Text(
                notification.message?.capitalizeFirst ?? "",
                style: Theme.of(context).textTheme.titleSmall,
              ),

              ///Date

              RichText(
                text: TextSpan(
                  text: "Date: ",
                  style: Theme.of(context).textTheme.titleSmall,
                  children: [
                    TextSpan(
                      text: notification.createdAt.formatDateToString,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
