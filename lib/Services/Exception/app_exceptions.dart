import 'package:flutter/foundation.dart';
import 'package:cricket_poc/lib_exports.dart';

class AppExceptions {
  static String get internetTitle => "No Internet";

  static String get normalErrorText => 'Something went wrong, Please try again';

  static String get socketExceptionText =>
      'Ensure you are connected to the internet';

  static String get serverError => 'Server Error';

  static get unAuthorizedText =>
      "UnAuthorized request, Please restart application or try again after some time";

  //! UnAuthorized Exception
  static Failure handleUnAuthorizedError({String? title}) {
    return Failure(
      title: serverError,
      message: title ?? unAuthorizedText,
    );
  }

  //! Socket Exception
  static Failure handleSocketException() {
    return Failure(
      title: internetTitle,
      message: socketExceptionText,
    );
  }

  //! Internal Server Exception
  static Failure handleInternalServerError({String? message}) {
    debugPrint("Internal ServerError Text");

    return Failure(
      title: serverError,
      message: message ?? normalErrorText,
    );
  }

  //! Bad Request Exception
  static Failure handleBadRequestException({String? message}) {
    debugPrint("Bad Request Error");

    return Failure(
      title: serverError,
      message: message ?? normalErrorText,
    );
  }

  //! My HTTP Client Exception
  static Failure handleMyHTTPClientException(MyHttpClientException exception) {
    return exception.failure as Failure;
  }

  //! Normal Exception
  static Failure handleException({required String error}) {
    ///Check For Socket Exception
    if (error.toString().contains("Socket")) {
      return AppExceptions.handleSocketException();
    }

    ///Only For Debug
    if (kDebugMode) {
      return Failure(
        title: serverError,
        message: error,
      );
    }

    return Failure(
      title: serverError,
      message: normalErrorText,
    );
  }
}
