import 'package:cricket_poc/lib_exports.dart';

final profileControllerPr = StateNotifierProvider<ProfileController, bool>(
    (ref) => ProfileController());

class ProfileController extends StateNotifier<bool> {
  ProfileController() : super(false);
}
