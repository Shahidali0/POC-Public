import 'dart:convert';

import 'package:cricket_poc/lib_exports.dart';
import 'package:fpdart/fpdart.dart';

final notificationRepositoryPr = Provider<NotificationRepository>(
  (ref) => NotificationRepository(
    homeServices: ref.read(homeServicesPr),
    ref: ref,
  ),
);

class NotificationRepository {
  final HomeServices _homeServices;
  final Ref _ref;

  NotificationRepository({
    required HomeServices homeServices,
    required Ref ref,
  })  : _homeServices = homeServices,
        _ref = ref;

  ///Get All Notifications List
  Future<List<NotificationJson>> getAllNotificationsList() async {
    try {
      List<NotificationJson> notifications = [];

      ///Load user
      final user = _ref.read(userJsonPr)?.user;

      final response = await _homeServices.getAllNotifications(
        userId: user!.userId!,
      );

      if (response != null) {
        notifications = NotificationJson.fromRawJson(response);
        // notifications = await compute(NotificationJson.fromRawJson, response);
      }

      return notifications;
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }

  ///Get User Notifications Count
  Future<int> getUserNotificationsCount() async {
    try {
      int notificationsCount = 0;

      ///Load user
      final user = _ref.read(userJsonPr)?.user;

      final response = await _homeServices.getUserNotificationCount(
        userId: user!.userId!,
      );

      if (response != null) {
        final data = jsonDecode(response);
        notificationsCount = data["unreadCount"];
      }

      return notificationsCount;
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }

  ///Update User Notification State
  FutureEither<String> updateUserNotificationStatus({
    required String bookingId,
  }) async {
    try {
      String message = "Failed to update notification";

      ///Load user
      final user = _ref.read(userJsonPr)?.user;

      final response = await _homeServices.updateUserNotificationStatus(
        userId: user!.userId!,
        bookingIds: [bookingId],
      );

      if (response != null) {
        final data = jsonDecode(response);
        message = data["message"];
      }

      return right(message);
    } on MyHttpClientException catch (error) {
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (e) {
      return left(AppExceptions.instance.handleException(error: e.toString()));
    }
  }
}
