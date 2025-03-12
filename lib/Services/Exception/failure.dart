class Failure {
  Failure({
    required this.title,
    required this.message,
  });

  String message;
  String? title;
}

///Create Abstract class of [_ApiException] to catch exception in [Failure] calss
abstract class _ApiException implements Exception {
  _ApiException({required this.failure});

  final Failure? failure;

  @override
  String toString() => '_ApiException(failure: $failure)';
}

///This [MyHttpClientException] Exception is to catch out any api Exception
///and To show that message in [futurebuilder] as CustomErrorException
class MyHttpClientException extends _ApiException {
  MyHttpClientException({required super.failure});
}
