import 'package:cricket_poc/lib_exports.dart';

final homeServicesPr = Provider<HomeServices>(
  (ref) => _HomeServicesImpl(
    apiHeaders: ref.read(apiHeadersPr),
  ),
);

sealed class HomeServices {
  Future<String?> getAllServices({
    required String sport,
    required String category,
    required String subCategory,
  });

  Future<String?> getFeaturedServices();

  Future<String?> findUserServices({required String userId});

  Future<String?> getUserBookings({required String userId});

  Future<String?> postService({required PostServiceDto postServiceDto});

  Future<String?> getAllCategories();
}

class _HomeServicesImpl implements HomeServices {
  final ApiHeaders _apiHeaders;

  _HomeServicesImpl({required ApiHeaders apiHeaders})
      : _apiHeaders = apiHeaders;

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
          "services?${sport.isNotEmpty ? "sport=$sport" : ""}${category.isNotEmpty ? "&category=$category" : ""}${subCategory.isNotEmpty ? "&subcategory=$subCategory" : ""}";
    }

    // final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: _apiHeaders.headers,
    );

    return response;
  }

  //* Get Featured Services List
  @override
  Future<String?> getFeaturedServices() async {
    const url = "services?featured=true";

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

  //* Post the Service
  @override
  Future<String?> postService({required PostServiceDto postServiceDto}) async {
    const url = "services";

    final body = postServiceDto.toRawJson();

    // final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.postService(
      urlEndPoint: url,
      body: body,
      headers: _apiHeaders.headers,
    );

    return response;
  }

  //* Get All Categories
  @override
  Future<String?> getAllCategories() async {
    const url = "category";

    // final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: _apiHeaders.headers,
    );

    return response;
  }
}
