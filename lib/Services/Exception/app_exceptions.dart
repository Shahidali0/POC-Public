import 'package:flutter/foundation.dart';
import 'package:cricket_poc/lib_exports.dart';

class AppExceptions {
  AppExceptions._();

  static AppExceptions get instance => AppExceptions._();

  String get internetTitle => "No Internet";

  String get normalErrorText => 'Something went wrong, Please try again';

  String get socketExceptionText => 'Ensure you are connected to the internet';

  String get serverError => 'Server Error';

  get unAuthorizedText =>
      "UnAuthorized request, Please restart application or try again after some time";

  get requiredYourInput =>
      "We need a few more details from you. Please update the required fields before moving forward";

  //! UnAuthorized Exception
  Failure handleUnAuthorizedError({String? title}) {
    return Failure(
      title: serverError,
      message: title ?? unAuthorizedText,
    );
  }

  //! Socket Exception
  Failure handleSocketException() {
    return Failure(
      title: internetTitle,
      message: socketExceptionText,
    );
  }

  //! Internal Server Exception
  Failure handleInternalServerError({String? message}) {
    debugPrint("Internal ServerError Text");

    return Failure(
      title: serverError,
      message: message ?? normalErrorText,
    );
  }

  //! Bad Request Exception
  Failure handleBadRequestException({String? message}) {
    debugPrint("Bad Request Error");

    return Failure(
      title: serverError,
      message: message ?? normalErrorText,
    );
  }

  //! My HTTP Client Exception
  Failure handleMyHTTPClientException(MyHttpClientException exception) {
    return exception.failure as Failure;
  }

  //! Normal Exception
  Failure handleException({required String error}) {
    ///Check For Socket Exception
    if (error.toString().contains("Socket")) {
      return AppExceptions.instance.handleSocketException();
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
