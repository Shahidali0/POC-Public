import 'dart:convert';
import 'dart:io';
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
    } on SocketException {
      return left(AppExceptions.instance.handleSocketException());
    } on MyHttpClientException catch (error) {
      ///Here --> error type: Failure
      return left(AppExceptions.instance.handleMyHTTPClientException(error));
    } catch (error) {
      return left(
          AppExceptions.instance.handleException(error: error.toString()));
    }
  }
}
