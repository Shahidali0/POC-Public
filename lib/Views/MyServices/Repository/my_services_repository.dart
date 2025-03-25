import 'dart:io';

import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/foundation.dart';

final myServicesRepositoryPr = Provider<MyServicesRepository>(
  (ref) => MyServicesRepository(
    homeServices: ref.read(homeServicesPr),
  ),
);

class MyServicesRepository {
  final HomeServices _homeServices;

  MyServicesRepository({required HomeServices homeServices})
      : _homeServices = homeServices;

  ///Get All Service
  Future<AllServicesJson?> findMyServices() async {
    try {
      AllServicesJson? findMyServices;

      final response =
          await _homeServices.findUserServices(userId: "123asf234234");

      if (response != null) {
        findMyServices = await compute(AllServicesJson.fromRawJson, response);
      }

      return findMyServices;
    } on SocketException catch (_) {
      throw AppExceptions.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.handleException(error: e.toString());
    }
  }

  ///Get User Bookings List
  Future<List<BookingsJson>> getMyBookings() async {
    try {
      List<BookingsJson> userBookings = [];

      final response = await _homeServices.getUserBookings(
          userId: "f9ee84d8-d0c1-7094-e0cf-5f9ecc4b3900");

      if (response != null) {
        userBookings = await compute(BookingsJson.fromRawJson, response);
      }

      return userBookings;
    } on SocketException catch (_) {
      throw AppExceptions.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.handleException(error: e.toString());
    }
  }
}
