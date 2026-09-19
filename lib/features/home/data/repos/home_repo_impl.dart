import 'package:docdoc/core/api/api_service.dart';
import 'package:docdoc/core/api/api_constants.dart';
import 'package:docdoc/features/home/data/models/home_model.dart';

class HomeRepoImpl {
  final ApiService _apiService;

  HomeRepoImpl(this._apiService);

  Future<HomeModel> fetchHome(String token) async {
    try {
      final response = await _apiService.get(
        endPoint: ApiConstants.homeEndPoint,
        token: token,
      );
      return HomeModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
