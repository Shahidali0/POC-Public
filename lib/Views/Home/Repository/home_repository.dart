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

  ///Get All Featured Services
  Future<AllServicesJson?> getFeaturedServices() async {
    try {
      AllServicesJson? featuredServices;

      final response = await _homeServices.getFeaturedServices();

      if (response != null) {
        featuredServices = await compute(AllServicesJson.fromRawJson, response);
      }

      return featuredServices;
    } on SocketException catch (_) {
      throw AppExceptions.instance.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }
}
