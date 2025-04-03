part of 'package:cricket_poc/Views/DashboardNavBar/dashboard_navbar_screen.dart';

final _navBarIndexPr = StateProvider<int>((ref) => 0);

final _showOrHideNavBarPr = StateProvider<bool>((ref) => true);

final allCategoriesPr = StateProvider<List<CategoryJson>>((ref) {
  return [];
});

final _getAllCategoriesListPr = FutureProvider<List<CategoryJson>>((ref) async {
  return ref.watch(navbarControllerPr.notifier).getAllCategories();
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

  ///Get all Categories
  Future<List<CategoryJson>> getAllCategories() async {
    final categories = await _navBarRepository.getAllCategories();

    _ref.read(allCategoriesPr.notifier).update((state) => state = categories);

    return categories;
  }
}
