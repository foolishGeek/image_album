import 'package:dio/dio.dart';
import 'package:image_album/core/config/network_config/network_config.dart';
import 'package:image_album/core/service/remote_service/api_request/api_request_interface.dart';
import 'package:image_album/core/service/remote_service/api_service/api_service_interface.dart';
import 'package:image_album/core/service/remote_service/api_service/interceptors.dart';

class ApiService extends IApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: NetworkConfig.networkConfig.baseUrl,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
          ),
        ) {
    _dio.interceptors.add(HeaderInterceptor());
  }

  @override
  Future<Response> execute(ApiRequest apiRequest) async {
    // All the incoming request handled here based on the `apiRequest`
    try {
      return switch (apiRequest) {
        GetRequest() => await _dio.get(apiRequest.path,
            queryParameters: apiRequest.queryParams,
            options: Options(
              headers: apiRequest.customHeaders,
            )),
        PostRequest() => await _dio.post(apiRequest.path,
            data: apiRequest.body,
            options: Options(headers: apiRequest.customHeaders))
      };
    } on DioException catch (exception) {
      throw Exception(
          '[${apiRequest.runtimeType}] ${apiRequest.path} failed: ${exception.message}');
    }
  }
}
