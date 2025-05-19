import 'dart:convert';
import 'package:cricket_poc/lib_exports.dart';
import 'package:fpdart/fpdart.dart';

final postServicesRepositoryPr = Provider<PostServicesRepository>(
  (ref) => PostServicesRepository(
    homeServices: ref.read(homeServicesPr),
  ),
);

class PostServicesRepository {
  final HomeServices _homeServices;

  PostServicesRepository({required HomeServices homeServices})
      : _homeServices = homeServices;

  ///Get All Locations List
  FutureEither<List<LocationsJson>> getAllLocations() async {
    try {
      List<LocationsJson> locationsJson = [];

      final response = await _homeServices.getAllLocations();

      if (response != null) {
        final list = LocationsJson.fromRawJson(response);
        locationsJson = List.from(list);
      }

      return right(locationsJson);
    } on MyHttpClientException catch (error) {
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (error) {
      return left(
          AppExceptions.instance.handleException(error: error.toString()));
    }
  }

  ///Post Service
  FutureEither<String?> postService(
      {required PostServiceDto postServiceDto}) async {
    try {
      String? message;

      final response =
          await _homeServices.postService(postServiceDto: postServiceDto);

      if (response != null) {
        final signUpData = jsonDecode(response);
        message = signUpData["message"];
      }

      return right(message);
    } on MyHttpClientException catch (error) {
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (error) {
      return left(
          AppExceptions.instance.handleException(error: error.toString()));
    }
  }
}
