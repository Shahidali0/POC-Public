part of 'package:cricket_poc/Views/Home/home_screen.dart';

final homeControllerPr = StateNotifierProvider<_HomeController, bool>(
  (ref) => _HomeController(
    homeRepository: ref.read(homeRepositoryPr),
    ref: ref,
  ),
);

final allCategoriesPr = StateProvider<List<CategoryJson>>((ref) {
  return [];
});

final _homeTabBarIndexPr = StateProvider<int>((ref) => 0);

class _HomeController extends StateNotifier<bool> {
  final HomeRepository _homeRepository;
  final Ref _ref;

  _HomeController({
    required HomeRepository homeRepository,
    required Ref ref,
  })  : _homeRepository = homeRepository,
        _ref = ref,
        super(false);

  ///Get all Categories
  Future<List<CategoryJson>> getAllCategories() async {
    if (!mounted) return [];

    final categories = await _homeRepository.getAllCategories();

    _ref.read(allCategoriesPr.notifier).update((state) => state = categories);

    return categories;
  }
}
