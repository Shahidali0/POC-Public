part of 'package:cricket_poc/Views/Filters/service_filter.dart';

final _selectedFilterIndexPr = StateProvider<int>((ref) => 0);

final filtersControllerPr = StateNotifierProvider<_FiltersController, bool>(
  (ref) => _FiltersController(),
);

class _FiltersController extends StateNotifier<bool> {
  _FiltersController() : super(false);

  final double _intialDistance = 0.1;

  late ValueNotifier<String?> sortValue;
  late ValueNotifier<String?> categoryValue;
  late ValueNotifier<String?> subCategoryValue;
  late ValueNotifier<String?> priceValue;

  ///Now we have set distance to[0.1]
  ///we have to multiply with [100] to show in [KM] format when submitting data
  late ValueNotifier<double> distanceValue;

  void initState() {
    sortValue = ValueNotifier(null);
    categoryValue = ValueNotifier(null);
    subCategoryValue = ValueNotifier(null);
    priceValue = ValueNotifier(null);
    distanceValue = ValueNotifier(_intialDistance);
  }

  ///Custom Dispose
  void disposeMethod() {
    sortValue.dispose();
    categoryValue.dispose();
    subCategoryValue.dispose();
    priceValue.dispose();
    distanceValue.dispose();
    super.dispose();
  }

  //* Clear All Filters
  void clearFilters() {
    sortValue.value = null;
    categoryValue.value = null;
    subCategoryValue.value = null;
    priceValue.value = null;
    distanceValue.value = _intialDistance;
  }
}
