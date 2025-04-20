import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cricket_poc/lib_exports.dart';

class ResponseHandler {
  ResponseHandler._();

  static ResponseHandler get instance => ResponseHandler._();

  Failure basicFailure = Failure(
    title: AppExceptions.instance.serverError,
    message: AppExceptions.instance.normalErrorText,
  );

  //! Handle HTTP Responses
  String? handleResponse({required http.Response response}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isEmpty) return null;
      return response.body;
    }

    ///Handle BadRequest  Error
    else if (response.statusCode == 400) {
      if (response.body.isEmpty) {
        throw MyHttpClientException(
          failure: AppExceptions.instance.handleUnAuthorizedError(),
        );
      }

      ///
      final responseData = jsonDecode(response.body);
      String title = responseData["message"]
          .toString()
          .replaceAll(".", "")
          .capitalizeFirst;
      String? message = responseData["error"]?.toString().capitalizeFirst;

      basicFailure = Failure(
        title: title,
        message: message ?? AppExceptions.instance.normalErrorText,
      );

      throw MyHttpClientException(failure: basicFailure);
    }

    ///Handle Un Authorize Status
    else if (response.statusCode == 401) {
      throw MyHttpClientException(
        failure: AppExceptions.instance.handleUnAuthorizedError(),
      );
    }

    ///Handle 403,404,500 Error Status
    else if (response.statusCode == 403 ||
        response.statusCode == 404 ||
        response.statusCode == 500) {
      if (response.body.isEmpty) {
        throw MyHttpClientException(
          failure: AppExceptions.instance.handleInternalServerError(),
        );
      }

      ///
      final responseData = jsonDecode(response.body);
      String title = responseData["message"]
          .toString()
          .replaceAll(".", "")
          .capitalizeFirst;
      String? message = responseData["error"]?.toString().capitalizeFirst;

      basicFailure = Failure(
        title: title,
        message: message ?? AppExceptions.instance.normalErrorText,
      );

      throw MyHttpClientException(failure: basicFailure);
    }

    ///Else if none of above conditions then
    else {
      throw MyHttpClientException(
        failure: AppExceptions.instance.handleException(
          error: AppExceptions.instance.normalErrorText,
        ),
      );
    }
  }

  //! Handle HTTP Stream Response
  static Future handleStreamResponse(
      {required http.StreamedResponse response}) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final streamData = await response.stream.bytesToString();

      return streamData;
    } else if (response.statusCode == 401) {
      throw MyHttpClientException(
          failure: AppExceptions.instance.handleUnAuthorizedError());
    } else {
      throw MyHttpClientException(
          failure: ResponseHandler.instance.basicFailure);
    }
  }
}
