import 'package:cricket_poc/lib_exports.dart';

final homeServicesPr = Provider<HomeServices>(
  (ref) => _HomeServicesImpl(
    apiHeaders: ref.read(apiHeadersPr),
  ),
);

sealed class HomeServices {
  Future<String?> findAllServices();

  Future<String?> findUserServices({
    required String userId,
  });

  Future<String?> getUserBookings({
    required String userId,
  });
}

class _HomeServicesImpl implements HomeServices {
  final ApiHeaders _apiHeaders;

  _HomeServicesImpl({required ApiHeaders apiHeaders})
      : _apiHeaders = apiHeaders;

  //* Get All Services List
  @override
  Future<String?> findAllServices() async {
    const url = "services";

    // final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: _apiHeaders.headers,
    );

    return response;
  }

  //* Get User Services List
  @override
  Future<String?> findUserServices({required String userId}) async {
    final url = "services?providerId=$userId";

    // final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: _apiHeaders.headers,
    );

    return response;
  }

  //* Get User Bookings
  @override
  Future<String?> getUserBookings({required String userId}) async {
    final url = "booking?userId=$userId";

    // final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: _apiHeaders.headers,
    );

    return response;
  }
}
