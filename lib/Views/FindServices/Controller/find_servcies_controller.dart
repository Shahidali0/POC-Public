import 'package:cricket_poc/lib_exports.dart';

final findServicesControllerPr =
    StateNotifierProvider<FindServciesController, bool>(
  (ref) => FindServciesController(
    findServiceRepo: ref.read(findServicesRepositoryPr),
  ),
);

final findServicesTabBarIndexPr = StateProvider<int>((ref) => 0);

final getAllServciesPr = FutureProvider<AllServicesJson?>(
  (ref) async {
    final updateFilter = ref.read(filtersControllerPr).updateFilters;

    final state = updateFilter
        ? ref.read(filtersControllerPr)
        : ref.read(filtersControllerPr.notifier).emptyFilter;

    return ref
        .read(findServicesControllerPr.notifier)
        .findAllServices(state: state);
  },
);

class FindServciesController extends StateNotifier<bool> {
  final FindServicesRepository _repository;

  FindServciesController({
    required FindServicesRepository findServiceRepo,
  })  : _repository = findServiceRepo,
        super(false);

  //* First character of the first and last word in a sentence
  String getInitials(String? sentence) {
    if (sentence == null || sentence.isEmpty) return '';

    List<String> words = sentence.trim().split(" ");

    if (words.length < 2) return words.first[0].toUpperCase();

    return (words.first[0] + words.last[0]).toUpperCase();
  }

  //* Find AllServices
  Future<AllServicesJson?> findAllServices(
          {required FiltersControllerState state}) =>
      _repository.getAllServices(state: state);
}
