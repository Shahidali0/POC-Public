import 'package:cricket_poc/lib_exports.dart';

final navbarRepositoryPr = Provider<NavBarRepository>(
  (ref) => NavBarRepository(
    homeServices: ref.read(homeServicesPr),
  ),
);

class NavBarRepository {
  final HomeServices _homeServices;

  NavBarRepository({
    required HomeServices homeServices,
  }) : _homeServices = homeServices;

  ///Get All Categories List
  Future<List<CategoryJson>> getAllCategories() async {
    try {
      List<CategoryJson> getAllCategories = [];

      final response = await _homeServices.getAllCategories();

      if (response != null) {
        getAllCategories = CategoryJson.fromRawJson(response);
        // getAllCategories = await compute(CategoryJson.fromRawJson, response);
      }

      return getAllCategories;
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }
}
