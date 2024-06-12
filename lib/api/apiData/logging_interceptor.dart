
import 'dart:developer';
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("--> ${options.method} ${options.path}");
    print(options.headers);

    String responseAsString = options.data.toString();

    log(" \n<-- START PARAMS: \n$responseAsString\nEND PARAMS -->\n<-- END HTTP");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
    String responseAsString = response.data.toString();
    log(" \n<-- START RESPONSE: \n$responseAsString\nEND RESPONSE -->\n<-- END HTTP");

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("<-- Error -->");
    print(err.error);
    print(err.message);
    super.onError(err, handler);
  }
}