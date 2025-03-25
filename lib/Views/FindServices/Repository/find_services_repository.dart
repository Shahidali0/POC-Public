import 'dart:io';

import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/foundation.dart';

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
  Future<AllServicesJson?> findAllServices() async {
    try {
      AllServicesJson? findAllServices;

      final response = await _homeServices.findAllServices();

      if (response != null) {
        findAllServices = await compute(AllServicesJson.fromRawJson, response);
      }

      return findAllServices;
    } on SocketException catch (_) {
      throw AppExceptions.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.handleException(error: e.toString());
    }
  }
}
