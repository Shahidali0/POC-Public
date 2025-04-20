import 'dart:io';
import 'package:cricket_poc/lib_exports.dart';

final profileRepositoryPr = Provider<ProfileRepository>(
  (ref) => ProfileRepository(
    profileServices: ref.read(profileServicesPr),
    localStorage: LocalStorage(),
    ref: ref,
  ),
);

final userJsonPr = StateProvider<UsersResponseJson?>((ref) {
  return null;
});

class ProfileRepository {
  final ProfileServices _profileServices;
  final LocalStorage _localStorage;
  final Ref _ref;

  ProfileRepository({
    required ProfileServices profileServices,
    required LocalStorage localStorage,
    required Ref ref,
  })  : _localStorage = localStorage,
        _profileServices = profileServices,
        _ref = ref;

  Future<UsersResponseJson?> getCurrentUser() async {
    //*Get userId
    final signInResponse = await _localStorage.getSignInResponse();

    if (signInResponse == null || signInResponse.accessToken == null) {
      return null;
    }

    String userId = "592e1478-f071-70e2-c2e2-a92acc58cc5f";

    //* Now get user details
    final user = await getUser(userId: userId);

    //* Update User Json
    _ref
        .read(userJsonPr.notifier)
        .update((state) => state = user as UsersResponseJson);
    return null;
  }

  ///Get User Profile Details by UserId
  Future<UsersResponseJson?> getUser({required String userId}) async {
    try {
      UsersResponseJson? usersJson;

      final response = await _profileServices.getUser(
        userId: userId,
      );

      if (response != null) {
        usersJson = UsersResponseJson.fromRawJson(response);
        // usersJson = await compute(UsersJson.fromRawJson, response);
      }

      return usersJson;
    } on SocketException catch (_) {
      throw AppExceptions.instance.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }

  ///Is User Authorized
  Future<bool> isAuthorized() async {
    return await _localStorage.isAuthorized();
  }
}
