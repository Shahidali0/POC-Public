part of 'package:cricket_poc/Views/Home/home_screen.dart';

final homeControllerPr = StateNotifierProvider<_HomeController, bool>(
  (ref) => _HomeController(
    homeRepository: ref.read(homeRepositoryPr),
    ref: ref,
  ),
);

final getFeaturedServicesPr = FutureProvider<AllServicesJson?>((ref) async {
  return ref.read(homeControllerPr.notifier).getFeaturedServices();
});

final getUserPr = FutureProvider<AllServicesJson?>((ref) async {
  return ref.read(homeControllerPr.notifier).getFeaturedServices();
});

class _HomeController extends StateNotifier<bool> {
  final Ref _ref;
  final HomeRepository _repository;

  _HomeController({
    required Ref ref,
    required HomeRepository homeRepository,
  })  : _ref = ref,
        _repository = homeRepository,
        super(false);

  //* Get all categories
  List<String> get getAllCattegoriesList =>
      _ref.read(allCategoriesPr).map((e) => e.category!).toSet().toList();

  //* Get Featured Services
  Future<AllServicesJson?> getFeaturedServices() =>
      _repository.getFeaturedServices();

  //* onTap Category

  void onTapCategory({
    required String category,
  }) {
    ///Clears the Filter Controller Data
    _ref.invalidate(filtersControllerPr);

    ///Now update the category value in FiltersController
    _ref.read(filtersControllerPr.notifier).updateCategoryValue(category);

    ///Now to fetch the services based on the category,
    ///Clear GetAllServcies List data
    _ref.invalidate(getAllServciesPr);

    ///Now change the bottom nav bar index
    _ref.read(navbarControllerPr.notifier).updateNavbarIndex(index: 1);
  }
}
