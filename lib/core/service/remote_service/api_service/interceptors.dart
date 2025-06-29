import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final defaultHeaders = {
      'Content-Type': 'application/json',
    };

    options.headers.addAll({
      ...defaultHeaders,
      ...options.headers,
    });

    return handler.next(options);
  }
}
