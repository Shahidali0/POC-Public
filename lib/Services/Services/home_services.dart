import 'dart:convert';

import 'package:cricket_poc/lib_exports.dart';

final homeServicesPr = Provider<HomeServices>(
  (ref) => _HomeServicesImpl(
    apiHeaders: ref.read(apiHeadersPr),
  ),
);

sealed class HomeServices {
  Future<String?> getAllNotifications({
    required String userId,
  });

  Future<String?> getAllServices({
    required String sport,
    required String category,
    required String subCategory,
  });

  Future<String?> getFeaturedServices();

  Future<String?> getMyServices({required String userId});

  Future<String?> getMyBookings({required String userId});

  Future<String?> getMyServicesBookings({required String serviceId});

  Future<String?> postService({required PostServiceDto postServiceDto});

  Future<String?> getAllCategories();

  Future<String?> createBooking({required CreateBookingDto bookingDto});

  Future<String?> cancelBooking({
    required CancelBookingDto cancelBookingDto,
  });

  Future<String?> updateMyServiceBookingStatus({
    required BookingStatusDto bookingStatusDto,
  });

  Future<String?> getUserNotificationCount({
    required String userId,
  });
  Future<String?> updateUserNotificationStatus({
    required String userId,
    required List<String> bookingIds,
  });
}

class _HomeServicesImpl implements HomeServices {
  final ApiHeaders _apiHeaders;

  _HomeServicesImpl({required ApiHeaders apiHeaders})
      : _apiHeaders = apiHeaders;

  //* Get All Notifications List
  @override
  Future<String?> getAllNotifications({
    required String userId,
  }) async {
    String url = "notification?userId=$userId";

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: headers,
    );

    return response;
  }

  //* Get All Services List
  @override
  Future<String?> getAllServices({
    required String sport,
    required String category,
    required String subCategory,
  }) async {
    String url;

    if (sport.isEmpty && category.isEmpty && subCategory.isEmpty) {
      url = "services";
    } else {
      url =
          "services?${sport.isNotEmpty ? "sport=${Uri.encodeComponent(sport)}" : ""}${category.isNotEmpty ? "&category=${Uri.encodeComponent(category)}" : ""}${subCategory.isNotEmpty ? "&subcategory=${Uri.encodeComponent(subCategory)}" : ""}";
    }

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: headers,
    );

    return response;
  }

  //* Get Featured Services List
  @override
  Future<String?> getFeaturedServices() async {
    const url = "services?featured=true";

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: headers,
    );

    return response;
  }

  //* Get User Services List
  @override
  Future<String?> getMyServices({required String userId}) async {
    final url = "services?providerId=$userId";

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: headers,
    );

    return response;
  }

  //* Get User Bookings
  @override
  Future<String?> getMyBookings({required String userId}) async {
    final url = "booking?userId=$userId";

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: headers,
    );

    return response;
  }

  //* Get My Services Bookings -- Someone booked my services List
  @override
  Future<String?> getMyServicesBookings({required String serviceId}) async {
    final url = "booking?serviceId=$serviceId";

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: headers,
    );

    return response;
  }

  //* Post the Service
  @override
  Future<String?> postService({required PostServiceDto postServiceDto}) async {
    const url = "services";

    final body = postServiceDto.toRawJson();

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.postService(
      urlEndPoint: url,
      body: body,
      headers: headers,
    );

    return response;
  }

  //* Get All Categories
  @override
  Future<String?> getAllCategories() async {
    const url = "category";

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: headers,
    );

    return response;
  }

  //* Create Booking--From user
  @override
  Future<String?> createBooking({required CreateBookingDto bookingDto}) async {
    const url = "booking";

    final body = bookingDto.toRawJson();

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.postService(
      urlEndPoint: url,
      body: body,
      headers: headers,
    );

    return response;
  }

  //! Delete Booking --user
  @override
  Future<String?> cancelBooking(
      {required CancelBookingDto cancelBookingDto}) async {
    const url = "booking";

    final body = cancelBookingDto.toJson();

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.patchService(
      urlEndPoint: url,
      body: body,
      headers: headers,
    );

    return response;
  }

  //* Update Booking Status
  @override
  Future<String?> updateMyServiceBookingStatus({
    required BookingStatusDto bookingStatusDto,
  }) async {
    const url = "booking";

    final body = bookingStatusDto.toJson();

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.patchService(
      urlEndPoint: url,
      body: body,
      headers: headers,
    );

    return response;
  }

  //* Get User Notification Count
  @override
  Future<String?> getUserNotificationCount({
    required String userId,
  }) async {
    String url = "notification/count?userId=$userId";

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: headers,
    );

    return response;
  }

  //* Update User Notification to Read Status
  @override
  Future<String?> updateUserNotificationStatus({
    required String userId,
    required List<String> bookingIds,
  }) async {
    String url = "notification";

    final body = json.encode({
      "userId": userId,
      "bookingIds": bookingIds,
    });

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.patchService(
      urlEndPoint: url,
      body: body,
      headers: headers,
    );

    return response;
  }
}
