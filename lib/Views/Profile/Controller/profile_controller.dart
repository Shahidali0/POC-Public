// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cricket_poc/lib_exports.dart';

final profileControllerPr =
    StateNotifierProvider<ProfileController, ProfileControllerState>(
  (ref) => ProfileController(
    ref: ref,
    profileRepository: ref.read(profileRepositoryPr),
  ),
);

class ProfileController extends StateNotifier<ProfileControllerState> {
  final ProfileRepository _profileRepository;
  final Ref _ref;

  ProfileController({
    required ProfileRepository profileRepository,
    required Ref ref,
  })  : _profileRepository = profileRepository,
        _ref = ref,
        super(
          ProfileControllerState(
            obsecureCurrentPassword: true,
            obsecureNewPassword: true,
            obsecureConfirmPassword: true,
            loading: false,
          ),
        );

  //* Update Current Password Obsecure
  void updateCurrentPasswordObsecure(bool value) => state = state.copyWith(
        obsecureCurrentPassword: value,
      );
  //* Update New Password Obsecure
  void updateNewPasswordObsecure(bool value) => state = state.copyWith(
        obsecureNewPassword: value,
      );
  //* Update Confirm Password Obsecure
  void updateConfirmPasswordObsecure(bool value) => state = state.copyWith(
        obsecureConfirmPassword: value,
      );

  ///Get User Profile Details
  Future isAuthorized({
    required BuildContext context,
    required VoidCallback redirectTo,
  }) async {
    final isAuthorized = await _profileRepository.isAuthorized();

    if (!context.mounted) return;

    ///Check if user is authorized or not
    if (!isAuthorized) {
      return AppRouter.instance.push(
        context: context,
        page: const LoginScreen(),
      );
    }

    ///If Authorized then go to Redirect Page
    else {
      redirectTo();
      return;
    }
  }

  ///Change Password
  void changePassword({
    required BuildContext context,
    required String currentPassword,
    required String newPassword,
  }) async {
    Utils.instance.hideFoucs(context);

    state = state.copyWith(loading: true);

    final response = await _profileRepository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    state = state.copyWith(loading: false);

    response.fold(
      (failure) {
        showErrorSnackBar(
          context: context,
          title: failure.title,
          content: failure.message,
        );
        return;
      },
      (success) {
        showSuccessSnackBar(
          context: context,
          content: success,
        );
        AppRouter.instance.pop(context);
      },
    );
  }

  ///Get User Id From UserJson
  String getUserId() {
    final userJson = _ref.read(userJsonPr)?.user;
    if (userJson != null) {
      return userJson.userId!;
    } else {
      return "";
    }
  }

  ///Logout
  FutureVoid logout(BuildContext context) async =>
      await _profileRepository.logout(context);
}

class ProfileControllerState {
  final bool obsecureCurrentPassword;
  final bool obsecureNewPassword;
  final bool obsecureConfirmPassword;
  final bool loading;

  ProfileControllerState({
    required this.obsecureCurrentPassword,
    required this.obsecureNewPassword,
    required this.obsecureConfirmPassword,
    required this.loading,
  });

  ProfileControllerState copyWith({
    bool? obsecureCurrentPassword,
    bool? obsecureNewPassword,
    bool? obsecureConfirmPassword,
    bool? loading,
  }) {
    return ProfileControllerState(
      obsecureCurrentPassword:
          obsecureCurrentPassword ?? this.obsecureCurrentPassword,
      obsecureNewPassword: obsecureNewPassword ?? this.obsecureNewPassword,
      obsecureConfirmPassword:
          obsecureConfirmPassword ?? this.obsecureConfirmPassword,
      loading: loading ?? this.loading,
    );
  }
}
