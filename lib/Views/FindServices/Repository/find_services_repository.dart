import 'dart:io';

import 'package:cricket_poc/lib_exports.dart';

final findServicesRepositoryPr = Provider<FindServicesRepository>(
  (ref) => FindServicesRepository(
    homeServices: ref.read(homeServicesPr),
  ),
);

class FindServicesRepository {
  final HomeServices _homeServices;

  FindServicesRepository({required HomeServices homeServices})
      : _homeServices = homeServices;

  ///Get All Service
  Future<AllServicesJson?> getAllServices(
      {required FiltersControllerState state}) async {
    try {
      AllServicesJson? findAllServices;

      final response = await _homeServices.getAllServices(
        sport: state.selectedSport,
        category: state.selectedCategory,
        subCategory: state.selectedSubCategory,
      );

      if (response != null) {
        findAllServices = AllServicesJson.fromRawJson(response);
        // findAllServices = await compute(AllServicesJson.fromRawJson, response);
      }

      return findAllServices;
    } on SocketException catch (_) {
      throw AppExceptions.instance.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }
}
