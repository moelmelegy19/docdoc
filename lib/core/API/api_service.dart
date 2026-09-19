import 'package:dio/dio.dart';
import 'api_constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.receiveDataWhenStatusError = true;
  }

  Future<Response> post({required String endPoint, required Map<String, dynamic> data}) async {
    return await _dio.post(endPoint, data: data);
  }
}