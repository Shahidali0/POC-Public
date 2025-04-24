import 'dart:io';
import 'package:cricket_poc/lib_exports.dart';

final myServicesRepositoryPr = Provider<MyServicesRepository>(
  (ref) => MyServicesRepository(
    homeServices: ref.read(homeServicesPr),
  ),
);

class MyServicesRepository {
  final HomeServices _homeServices;

  MyServicesRepository({required HomeServices homeServices})
      : _homeServices = homeServices;

  ///Get My Service
  Future<AllServicesJson?> getMyServicesList() async {
    try {
      AllServicesJson? getMyServices;

      final response = await _homeServices.findUserServices(
        userId: "592e1478-f071-70e2-c2e2-a92acc58cc5f",
      );

      if (response != null) {
        getMyServices = AllServicesJson.fromRawJson(response);
        // findMyServices = await compute(AllServicesJson.fromRawJson, response);
      }

      return getMyServices;
    } on SocketException catch (_) {
      throw AppExceptions.instance.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }

  ///Get User Bookings List
  Future<List<BookingsJson>> getMyBookings() async {
    try {
      List<BookingsJson> userBookings = [];

      final response = await _homeServices.getUserBookings(
        userId: "592e1478-f071-70e2-c2e2-a92acc58cc5f",
        // userId: "f9ee84d8-d0c1-7094-e0cf-5f9ecc4b3900",
      );

      if (response != null) {
        userBookings = BookingsJson.fromRawJson(response);
        // userBookings = await compute(BookingsJson.fromRawJson, response);
      }

      return userBookings;
    } on SocketException catch (_) {
      throw AppExceptions.instance.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }
}
