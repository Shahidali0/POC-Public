import 'dart:io';
import 'package:cricket_poc/lib_exports.dart';

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
}
