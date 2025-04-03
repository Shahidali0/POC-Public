part of 'package:cricket_poc/Views/Home/home_screen.dart';

final homeControllerPr = StateNotifierProvider<_HomeController, bool>(
  (ref) => _HomeController(
      // homeRepository: ref.read(homeRepositoryPr),
      // ref: ref,
      ),
);

final _homeTabBarIndexPr = StateProvider<int>((ref) => 0);

class _HomeController extends StateNotifier<bool> {
  _HomeController() : super(false);
}
