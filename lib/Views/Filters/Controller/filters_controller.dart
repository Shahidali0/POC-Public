// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:cricket_poc/Views/Filters/service_filter.dart';

const double _intialDistance = 0.1;

final _selectedFilterIndexPr = StateProvider<int>((ref) => 0);

final filtersControllerPr =
    StateNotifierProvider<_FiltersController, FiltersControllerState>(
  (ref) => _FiltersController(
    ref: ref,
  ),
);

class _FiltersController extends StateNotifier<FiltersControllerState> {
  final Ref _ref;

  _FiltersController({
    required Ref ref,
  })  : _ref = ref,
        super(
          FiltersControllerState(
            selectedSport: "",
            selectedCategory: "",
            selectedSubCategory: "",
            selectedPrice: "",
            selectedDistance: _intialDistance,
            loading: false,
          ),
        );

  List<CategoryJson> allCategories = [];

  ///Filters Page LeftMenu Data
  List<String> get filtersData => [
        "Sport",
        "Category",
        "Sub Category",
        // "Price",
        // "Distance",
      ];

  ///Initialise
  void initState() {
    allCategories = _ref.read(allCategoriesPr);

    Future.microtask(() {
      ///Update Sport Value
      final sport = allCategories.map((e) => e.sport!).toList().first;
      state = state.copyWith(selectedSport: sport);
    });
  }

  //* Clear All Filters
  void clearFilters() {
    state = state.copyWith(
      selectedCategory: "",
      selectedSubCategory: "",
      selectedPrice: "",
      selectedDistance: _intialDistance,
      loading: false,
    );
  }

  //* Update SportValue
  void updateSportValue(String? value) {
    state = state.copyWith(
      selectedSport: value,
      selectedCategory: null,
    );
  }

  //* Update Category Value
  void updateCategoryValue(String? value) {
    state = state.copyWith(
      selectedCategory: value,
      selectedSubCategory: null,
    );
  }

  //* Update SubCategory Value
  void updateSubCategoryValue(String? value) {
    state = state.copyWith(selectedSubCategory: value);
  }

  //* Update Price Value
  void updatePriceValue(String? value) {
    state = state.copyWith(selectedPrice: value);
  }

  //* Update Distance Value
  void updateDistanceValue(double value) {
    state = state.copyWith(selectedDistance: value);
  }

  //* Get All Categories
  FutureVoid loadAllCategories() async {
    state.loading = true;

    allCategories =
        await _ref.read(navbarControllerPr.notifier).getAllCategories();

    state.loading = false;
  }

  //*Get Sports List
  List<String> get getSportsData =>
      allCategories.map((e) => e.sport!).toSet().toList();

  //*Get Categories List
  List<String> get getCategoriesData {
    final filteredCategories = allCategories
        .where((item) => item.sport == state.selectedSport)
        .toList();

    return filteredCategories.map((e) => e.category!).toSet().toList();
  }

  //*Get SubCategories List
  List<String> get getSubCategoriesData {
    final filteredList = allCategories
        .where((item) =>
            item.category == state.selectedCategory &&
            item.sport == state.selectedSport)
        .firstOrNull;

    return filteredList?.subcategories ?? [];
  }
}

///State Object for maintaining state
class FiltersControllerState {
  String selectedSport;
  String selectedCategory;
  String selectedSubCategory;
  String selectedPrice;
  double selectedDistance;
  bool loading;

  FiltersControllerState({
    required this.selectedSport,
    required this.selectedCategory,
    required this.selectedSubCategory,
    required this.selectedPrice,
    required this.selectedDistance,
    required this.loading,
  });

  FiltersControllerState copyWith({
    String? selectedSport,
    String? selectedCategory,
    String? selectedSubCategory,
    String? selectedPrice,
    double? selectedDistance,
    bool? loading,
  }) {
    return FiltersControllerState(
      selectedSport: selectedSport ?? this.selectedSport,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSubCategory: selectedSubCategory ?? this.selectedSubCategory,
      selectedPrice: selectedPrice ?? this.selectedPrice,
      selectedDistance: selectedDistance ?? this.selectedDistance,
      loading: loading ?? this.loading,
    );
  }
}
