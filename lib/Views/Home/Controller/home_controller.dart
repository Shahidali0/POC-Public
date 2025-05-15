part of 'package:cricket_poc/Views/Home/home_screen.dart';

final homeControllerPr = StateNotifierProvider<_HomeController, bool>(
  (ref) => _HomeController(
    homeRepository: ref.read(homeRepositoryPr),
    ref: ref,
  ),
);

final getFeaturedServicesFtPr = FutureProvider.autoDispose<AllServicesJson?>(
  (ref) async {
    return ref.read(homeControllerPr.notifier).getFeaturedServices();
  },
);

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
  List<CategoryJson> get getAllCategoriesList =>
      _ref.read(allCategoriesPr).toSet().toList();

  //* Get Featured Services
  Future<AllServicesJson?> getFeaturedServices() =>
      _repository.getFeaturedServices();

  //* Load Search Filter Data
  List<SearchFilterModel> getSearchFilterData() {
    ///Used Set to remove duplicate values
    List<SearchFilterModel> searchFilterModel = [];

    ///From getAllCategoriesList get the sport, category and subcategory
    for (var element in getAllCategoriesList) {
      ///Now Add Sport
      searchFilterModel.add(
        SearchFilterModel(
          result: element.sport!,
          sport: element.sport,
        ),
      );

      ///Now Add Category
      searchFilterModel.add(
        SearchFilterModel(
          result: element.category!,
          sport: element.sport,
          category: element.category,
        ),
      );

      ///Now Add SubCategory
      for (var subCategory in element.subcategories!) {
        searchFilterModel.add(
          SearchFilterModel(
            result: subCategory,
            sport: element.sport,
            category: element.category,
            subCategory: subCategory,
          ),
        );
      }
    }

    return searchFilterModel.toList();
  }

  //* onTap Category
  void onTapCategory({
    required String? sport,
    required String? category,
    String? subCategory,
    required BuildContext context,
  }) {
    ///This will clear the filters and set the default values
    _ref.invalidate(filtersControllerPr);

    ///This will update the filters -- Sport, Category and SubCategory
    _ref.read(filtersControllerPr.notifier).updateSportValue(sport);
    _ref.read(filtersControllerPr.notifier).updateCategoryValue(category);
    _ref.read(filtersControllerPr.notifier).updateSubCategoryValue(subCategory);

    ///Apply the filters
    _ref.read(filtersControllerPr.notifier).onApplyFilters(context: context);

    ///Change the bottom nav bar index to 1
    _ref.read(navbarControllerPr.notifier).updateNavbarIndex(index: 1);
  }

  /// Show Search Widget
  ///This method will show the search widget
  ///and return the selected value from the search widget
  ///and then we can use that value to filter the services
  ///based on the selected value
  void showSearchWidget({required BuildContext context}) async {
    final searchFilterData = getSearchFilterData();

    //*If searchFilterData is empty then show a message
    if (searchFilterData.isEmpty) {
      showErrorSnackBar(context: context, content: "Search data not found");
      return;
    }

    /* Show Search Widget */
    final response = await showSearch(
      context: context,
      delegate: HomeSearchDelegate(searchFilterData),
    );

    if (response == null) return;

    if (context.mounted) {
      onTapCategory(
        sport: response.sport,
        category: response.category,
        subCategory: response.subCategory,
        context: context,
      );
    }
  }
}
