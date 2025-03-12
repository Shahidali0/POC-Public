import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cricket_poc/lib_exports.dart';

class ResponseHandler {
  static Failure basicFailure = Failure(
    title: AppExceptions.serverError,
    message: AppExceptions.normalErrorText,
  );

  //! Handle HTTP Responses
  static handleResponse({required http.Response response}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isEmpty) return null;
      return response.body;
    }

    ///Handle BadRequest  Error
    else if (response.statusCode == 400) {
      if (response.body.isEmpty) {
        throw MyHttpClientException(
            failure: AppExceptions.handleUnAuthorizedError());
      }

      ///
      final responseData = jsonDecode(response.body);
      String message =
          responseData["message"].toString().replaceAll(".", "").toLowerCase();
      String status = responseData["status"].toString().toLowerCase();
      if (status.toLowerCase().contains("error")) {
        basicFailure = Failure(
          title: AppExceptions.serverError,
          message: message,
        );
      }

      throw MyHttpClientException(failure: basicFailure);
    }

    ///Handle Un Authorize Status
    else if (response.statusCode == 401) {
      throw MyHttpClientException(
        failure: AppExceptions.handleUnAuthorizedError(),
      );
    }

    ///Handle 403,404,500 Error Status
    else if (response.statusCode == 403 ||
        response.statusCode == 404 ||
        response.statusCode == 500) {
      if (response.body.isEmpty) {
        throw MyHttpClientException(
            failure: AppExceptions.handleInternalServerError());
      }

      ///
      final responseData = jsonDecode(response.body);
      String message =
          responseData["message"].toString().replaceAll(".", "").toLowerCase();
      String status = responseData["status"].toString().toLowerCase();
      if (status.toLowerCase().contains("error")) {
        basicFailure = Failure(
          title: AppExceptions.serverError,
          message: message,
        );
      }

      throw MyHttpClientException(failure: basicFailure);
    }

    ///Else if none of above conditions then
    else {
      throw MyHttpClientException(
          failure: AppExceptions.handleException(error: ""));
    }
  }

  //! Handle HTTP Responses Without Dialogs
  static Future handleResponseWithoutDialogs(
      {required http.Response response}) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isEmpty) return null;

      return response.body;
    }

    ///Else if none of above conditions then
    else {
      if (response.body.isNotEmpty) {
        final body = jsonDecode(response.body);
        final message = body["message"];
        throw MyHttpClientException(
          failure: Failure(title: AppExceptions.serverError, message: message),
        );
      }
      throw MyHttpClientException(failure: basicFailure);
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
          failure: AppExceptions.handleUnAuthorizedError());
    } else {
      throw MyHttpClientException(failure: basicFailure);
    }
  }
}
