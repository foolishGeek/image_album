// Interface for the API request
import 'package:dio/dio.dart';
import 'package:image_album/core/service/remote_service/api_request/api_request_interface.dart';

abstract class IApiService {
  Future<Response> execute(ApiRequest apiRequest);
}