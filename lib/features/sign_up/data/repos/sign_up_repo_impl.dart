import 'package:docdoc/core/api/api_service.dart';
import 'package:docdoc/core/api/api_constants.dart';

class SignUpRepoImpl {
  final ApiService _apiService;

  SignUpRepoImpl(this._apiService);

  Future<dynamic> register(
    String name,
    String email,
    String phone,
    String gender,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await _apiService.post(
        endPoint: ApiConstants.registerEndPoint,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'gender': gender,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}