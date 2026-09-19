import 'package:docdoc/core/api/api_service.dart';
import 'package:docdoc/core/api/api_constants.dart';

class SignInRepoImpl {
  final ApiService _apiService;

  SignInRepoImpl(this._apiService);

  Future<dynamic> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        endPoint: ApiConstants.loginEndPoint,
        data: {
          'email': email,
          'password': password,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}