import 'package:cricket_poc/lib_exports.dart';

final homeControllerPr =
    StateNotifierProvider<HomeController, bool>((ref) => HomeController());

final homeTabBarIndexPr = StateProvider<int>((ref) => 0);

class HomeController extends StateNotifier<bool> {
  HomeController() : super(false);
}
