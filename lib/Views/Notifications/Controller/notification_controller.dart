import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

final notificationControllerPr =
    StateNotifierProvider<NotificationController, bool>(
  (ref) => NotificationController(
    notificationRepository: ref.read(notificationRepositoryPr),
  ),
);

final getNotificationCountFtPr = FutureProvider<int>(
  (ref) async {
    return ref
        .read(notificationControllerPr.notifier)
        .getUserNotificationsCount();
  },
);

class NotificationController extends StateNotifier<bool> {
  final NotificationRepository _notificationRepository;

  NotificationController({
    required NotificationRepository notificationRepository,
  })  : _notificationRepository = notificationRepository,
        super(false);

  //* Get All Notifications
  Future<List<NotificationJson>> getAllNotificationsList() =>
      _notificationRepository.getAllNotificationsList();

  //* Get All Notifications Count
  Future<int> getUserNotificationsCount() =>
      _notificationRepository.getUserNotificationsCount();

  //* Update User Notification Status as Read
  Future<bool> updateNotificationStatus({
    required BuildContext context,
    required String bookingId,
  }) async {
    state = true;

    final response = await _notificationRepository.updateUserNotificationStatus(
      bookingId: bookingId,
    );

    state = false;

    return response.fold(
      (failure) {
        showErrorSnackBar(
          context: context,
          title: failure.title,
          content: failure.message,
        );

        return false;
      },
      (message) {
        showSuccessSnackBar(
          context: context,
          content: message,
        );

        return true;
      },
    );
  }
}
