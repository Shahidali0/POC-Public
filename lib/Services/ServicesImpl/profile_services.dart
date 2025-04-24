import 'package:cricket_poc/lib_exports.dart';

final profileServicesPr = Provider<ProfileServices>(
  (ref) => _ProfileServicesImpl(apiHeaders: ref.read(apiHeadersPr)),
);

sealed class ProfileServices {
  Future<String?> getUser({required String userId});

  Future<String?> getUserByUserName({required String userName});
}

class _ProfileServicesImpl implements ProfileServices {
  final ApiHeaders _apiHeaders;

  _ProfileServicesImpl({required ApiHeaders apiHeaders})
      : _apiHeaders = apiHeaders;

//* Get User by UserId
  @override
  Future<String?> getUser({required String userId}) async {
    final url = "user?userId=$userId";

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: headers,
    );

    return response;
  }

  //* Get User by UserName
  @override
  Future<String?> getUserByUserName({required String userName}) async {
    final url = "user?username=$userName";

    final headers = await _apiHeaders.getHeadersWithToken();

    final response = await BaseHttpClient.getService(
      urlEndPoint: url,
      headers: headers,
    );

    return response;
  }
}
