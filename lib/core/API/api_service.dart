import 'package:dio/dio.dart';
import 'api_constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.receiveDataWhenStatusError = true;
    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  /// POST request — sends JSON body
  Future<Response> post({
    required String endPoint,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await _dio.post(
      endPoint,
      data: data,
      options: _buildOptions(token),
    );
  }

  /// POST with FormData (multipart)
  Future<Response> postFormData({
    required String endPoint,
    required FormData formData,
    String? token,
  }) async {
    return await _dio.post(
      endPoint,
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  /// GET request — optionally authenticated
  Future<Response> get({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(
      endPoint,
      queryParameters: queryParameters,
      options: _buildOptions(token),
    );
  }

  Options _buildOptions(String? token) {
    return Options(
      headers: {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }
}