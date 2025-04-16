part of 'package:cricket_poc/Views/DashboardNavBar/dashboard_navbar_screen.dart';

final _navBarIndexPr = StateProvider<int>((ref) => 0);

final _showOrHideNavBarPr = StateProvider<bool>((ref) => true);

final allCategoriesPr = StateProvider<List<CategoryJson>>((ref) {
  return [];
});

final userJsonPr = StateProvider<UsersJson?>((ref) {
  return null;
});

final _getAllCategoriesListPr = FutureProvider<List<CategoryJson>>((ref) async {
  return ref.watch(navbarControllerPr.notifier).loadData();
});

final navbarControllerPr = StateNotifierProvider<NavbarController, bool>(
  (ref) => NavbarController(
    navBarRepository: ref.read(navbarRepositoryPr),
    ref: ref,
  ),
);

class NavbarController extends StateNotifier<bool> {
  final NavBarRepository _navBarRepository;
  final Ref _ref;

  NavbarController({
    required NavBarRepository navBarRepository,
    required Ref ref,
  })  : _navBarRepository = navBarRepository,
        _ref = ref,
        super(false);

  ///Update Navbar Index
  void updateNavbarIndex({required int index}) {
    _ref.read(_navBarIndexPr.notifier).update((st) => st = index);
  }

  ///Load all required api's
  Future<List<CategoryJson>> loadData() async {
    final response = await Future.wait([
      _navBarRepository.getAllCategories(),
      _navBarRepository.getUser(),
    ]);

    //* Update Categories List
    _ref
        .read(allCategoriesPr.notifier)
        .update((state) => state = response[0] as List<CategoryJson>);

    //* Update User Json
    _ref
        .read(userJsonPr.notifier)
        .update((state) => state = response[1] as UsersJson);

    return response[0] as List<CategoryJson>;
  }

  ///Get all Categories
  Future<List<CategoryJson>> getAllCategories() async {
    final categories = await _navBarRepository.getAllCategories();

    _ref.read(allCategoriesPr.notifier).update((state) => state = categories);

    return categories;
  }
}
