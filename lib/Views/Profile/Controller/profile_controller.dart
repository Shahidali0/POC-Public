import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

final profileControllerPr = StateNotifierProvider<ProfileController, bool>(
  (ref) => ProfileController(
    ref: ref,
    profileRepository: ref.read(profileRepositoryPr),
  ),
);

final isAuthorizedPr = StateProvider<bool?>((ref) => null);

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _profileRepository;
  final Ref _ref;

  ProfileController({
    required ProfileRepository profileRepository,
    required Ref ref,
  })  : _profileRepository = profileRepository,
        _ref = ref,
        super(false);

  ///Get User Profile Details
  Future isAuthorized({
    required BuildContext context,
    required VoidCallback redirectTo,
  }) async {
    final isAuthorized =
        _ref.read(isAuthorizedPr) ?? await _profileRepository.isAuthorized();

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

  ///Logout
  FutureVoid logout(BuildContext context) async =>
      await _profileRepository.logout(context);
}
