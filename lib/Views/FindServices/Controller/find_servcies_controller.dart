import 'package:cricket_poc/lib_exports.dart';

final findServicesControllerPr =
    StateNotifierProvider<FindServciesController, bool>(
        (ref) => FindServciesController());

final findServicesTabBarIndexPr = StateProvider<int>((ref) => 0);

class FindServciesController extends StateNotifier<bool> {
  FindServciesController() : super(false);
}
