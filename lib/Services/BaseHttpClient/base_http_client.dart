import 'package:http/http.dart' as mhttp;
import 'package:pretty_http_logger/pretty_http_logger.dart' as httplogger;
import 'package:cricket_poc/lib_exports.dart';

///Middleware to show http logs
httplogger.HttpWithMiddleware http = httplogger.HttpWithMiddleware.build(
  middlewares: [
    httplogger.HttpLogger(logLevel: httplogger.LogLevel.BODY),
    httplogger.HttpLogger(logLevel: httplogger.LogLevel.HEADERS),
  ],
);

//! hideDialogs=true : When we use Future/Stream builders to
//! Show response then we don't need dialogs for any kind of error
class BaseHttpClient {
  ///Get Service
  static Future getService({
    required String urlEndPoint,
    required Map<String, String> headers,
    bool isAuthUrl = false,
  }) async {
    Uri uri = Uri.parse(MyKeys.instance.baseUrl(isAuthUrl) + urlEndPoint);

    final response = await http.get(uri, headers: headers);

    return ResponseHandler.instance.handleResponse(response: response);
  }

  ///Delete Service
  static Future deleteService({
    required String urlEndPoint,
    required Map<String, String> headers,
    bool isAuthUrl = false,
  }) async {
    Uri uri = Uri.parse(MyKeys.instance.baseUrl(isAuthUrl) + urlEndPoint);

    final response = await http.delete(uri, headers: headers);

    return ResponseHandler.instance.handleResponse(response: response);
  }

  ///Post Service
  static Future<String?> postService({
    required String urlEndPoint,
    required Object? body,
    required Map<String, String> headers,
    bool isAuthUrl = false,
  }) async {
    Uri uri = Uri.parse(MyKeys.instance.baseUrl(isAuthUrl) + urlEndPoint);

    final response = await http.post(
      uri,
      body: body,
      headers: headers,
    );

    return ResponseHandler.instance.handleResponse(response: response);
  }

  ///Put Service
  static Future putService({
    required String urlEndPoint,
    required Object body,
    required Map<String, String> headers,
    bool isAuthUrl = false,
  }) async {
    Uri uri = Uri.parse(MyKeys.instance.baseUrl(isAuthUrl) + urlEndPoint);
    final response = await http.put(
      uri,
      body: body,
      headers: headers,
    );

    return ResponseHandler.instance.handleResponse(response: response);
  }

  ///Patch Service
  static Future patchService({
    required String urlEndPoint,
    required Object body,
    required Map<String, String> headers,
    bool isAuthUrl = false,
  }) async {
    Uri uri = Uri.parse(MyKeys.instance.baseUrl(isAuthUrl) + urlEndPoint);
    final response = await http.patch(
      uri,
      body: body,
      headers: headers,
    );

    return ResponseHandler.instance.handleResponse(response: response);
  }

  ///Put Service
  static Future multiPartService({
    required String urlEndPoint,
    required String filePath,
    required Map<String, String> headers,
    bool isAuthUrl = false,
  }) async {
    Uri uri = Uri.parse(MyKeys.instance.baseUrl(isAuthUrl) + urlEndPoint);

    final request = mhttp.MultipartRequest('POST', uri);

    request.files.add(await mhttp.MultipartFile.fromPath('file', filePath));

    request.headers.addAll(headers);

    mhttp.StreamedResponse response = await request.send();

    return ResponseHandler.handleStreamResponse(response: response);
  }
}
