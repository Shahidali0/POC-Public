import 'package:cricket_poc/lib_exports.dart';

final profileServicesPr = Provider<ProfileServices>(
  (ref) => _ProfileServicesImpl(apiHeaders: ref.read(apiHeadersPr)),
);

sealed class ProfileServices {
  Future<String?> getUser({required String userId});
}

class _ProfileServicesImpl implements ProfileServices {
  final ApiHeaders _apiHeaders;

  _ProfileServicesImpl({required ApiHeaders apiHeaders})
      : _apiHeaders = apiHeaders;

  @override
  Future<String?> getUser({required String userId}) async {
    final url = "user?userId=$userId";
    //592e1478-f071-70e2-c2e2-a92acc58cc5f";

    // final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: _apiHeaders.headers,
    );

    return response;
  }
}
