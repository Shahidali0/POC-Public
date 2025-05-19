import 'dart:convert';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

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

  ///Update User Json
  void _updateUserJson({required UsersResponseJson? userJson}) {
    _ref.read(userJsonPr.notifier).update((state) => state = userJson);
  }

  ///Get Cuurrent User
  Future<UsersResponseJson?> getCurrentUser() async {
    //*Get userId
    final signInResponse = await _localStorage.getSignInResponse();

    if (signInResponse == null ||
        signInResponse.accessToken == null ||
        signInResponse.emailId == null) {
      return null;
    }

    //* Now get user details
    final user = await _getUserByUserName(userName: signInResponse.emailId!);

    //* If user is null then delete the login details
    if (user == null) {
      await _localStorage.deleteLoginDetails();
    }

    ///Update UserJson
    _updateUserJson(userJson: user);

    return user;
  }

  ///Get User Details by UserId
  Future<UsersResponseJson?> getUserByUserId({required String userId}) async {
    try {
      UsersResponseJson? userJson;

      final response = await _profileServices.getUser(
        userId: userId,
      );

      if (response != null) {
        userJson = UsersResponseJson.fromRawJson(response);
        // usersJson = await compute(UsersJson.fromRawJson, response);
      }

      return userJson;
    } catch (error) {
      throw Exception(error);
    }
  }

  ///Get User Details by UserName
  ///Here we are not throwing the error bcz we dont want to block
  ///the UI if the user is not found
  Future<UsersResponseJson?> _getUserByUserName(
      {required String userName}) async {
    UsersResponseJson? userJson;
    try {
      final response = await _profileServices.getUserByUserName(
        userName: userName,
      );

      if (response != null) {
        userJson = UsersResponseJson.fromRawJson(response);
        // usersJson = await compute(UsersJson.fromRawJson, response);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return userJson;
  }

  ///Is User Authorized
  Future<bool> isAuthorized() async {
    return await _localStorage.isAuthorized();
  }

  ///Change User Password
  FutureEither<String> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      String message = "";

      final otpResult = await _profileServices.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (otpResult != null) {
        final otpResponse = jsonDecode(otpResult);
        message = otpResponse["message"];
      }

      return right(message);
    } on MyHttpClientException catch (error) {
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (error) {
      return left(
          AppExceptions.instance.handleException(error: error.toString()));
    }
  }

  ///Logout User
  FutureVoid logout(BuildContext context) async {
    return LogHelper.instance.showPlatformDialog(
      context: context,
      isDestructiveAction: true,
      title: "Are you sure",
      content: "Do you want to logout?",
      okText: "Logout",
      onOk: () async {
        await _localStorage.deleteLoginDetails();

        ///Refresh Some Providers

        _ref.invalidate(navbarControllerPr);
        _ref.invalidate(userJsonPr);
        _ref.invalidate(getMyServicesListFtPr);
        _ref.invalidate(getMyBookingsFtPr);

        if (!context.mounted) return;

        AppRouter.instance.pop(context);

        AppRouter.instance.pushOff(
          context: context,
          page: const DashboardScreen(),
        );
        return;
      },
    );
  }
}
