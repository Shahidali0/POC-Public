import 'dart:convert';
import 'dart:io';
import 'package:cricket_poc/lib_exports.dart';
import 'package:fpdart/fpdart.dart';

final sportzHubRepositoryPr = Provider<SportzHubRepository>(
  (ref) => SportzHubRepository(
    ref: ref,
    homeServices: ref.read(homeServicesPr),
  ),
);

class SportzHubRepository {
  final HomeServices _homeServices;
  final Ref _ref;

  SportzHubRepository({required HomeServices homeServices, required Ref ref})
      : _homeServices = homeServices,
        _ref = ref;

  ///Get My Service
  Future<AllServicesJson?> getMyServicesList() async {
    try {
      AllServicesJson? getMyServices;

      ///Get Userid
      final userId = _ref.read(profileControllerPr.notifier).getUserId();

      ///Get My Services
      final response = await _homeServices.findUserServices(
        userId: userId,
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

      ///Get Userid
      final userId = _ref.read(profileControllerPr.notifier).getUserId();

      ///Get User Bookings
      final response = await _homeServices.getUserBookings(
        userId: userId,
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

  ///Delete Booking
  FutureEither<String> deleteBooking({
    required String userId,
    required String bookingId,
  }) async {
    try {
      String message = "";

      ///Delete Booking
      final response = await _homeServices.deleteBooking(
        userId: userId,
        bookingId: bookingId,
      );

      if (response != null) {
        final decoded = jsonDecode(response);
        message = decoded["message"];
      }

      return right(message);
    } on SocketException catch (_) {
      return left(AppExceptions.instance.handleSocketException());
    } on MyHttpClientException catch (error) {
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (e) {
      return left(AppExceptions.instance.handleException(error: e.toString()));
    }
  }
}
