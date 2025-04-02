import 'dart:io';

import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/foundation.dart';

final homeRepositoryPr = Provider<HomeRepository>(
  (ref) => HomeRepository(
    homeServices: ref.read(homeServicesPr),
  ),
);

class HomeRepository {
  final HomeServices _homeServices;

  HomeRepository({required HomeServices homeServices})
      : _homeServices = homeServices;

  ///Get All Categories List
  Future<List<CategoryJson>> getAllCategories() async {
    try {
      List<CategoryJson> getAllCategories = [];

      final response = await _homeServices.getAllCategories();

      if (response != null) {
        getAllCategories = await compute(CategoryJson.fromRawJson, response);
      }

      return getAllCategories;
    } on SocketException catch (_) {
      throw AppExceptions.instance.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }
}
