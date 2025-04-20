import 'package:cricket_poc/lib_exports.dart';

final profileControllerPr = StateNotifierProvider<ProfileController, bool>(
  (ref) => ProfileController(
    profileRepository: ref.read(profileRepositoryPr),
  ),
);

final isAuthroizedPr = FutureProvider<bool>((ref) async {
  return ref.read(profileControllerPr.notifier).isAuthorized();
});

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _profileRepository;

  ProfileController({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(false);

  ///Get User Profile Details
  Future<bool> isAuthorized() async => await _profileRepository.isAuthorized();
}
