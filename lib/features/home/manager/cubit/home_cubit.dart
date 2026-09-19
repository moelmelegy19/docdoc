import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/features/home/data/repos/home_repo_impl.dart';
import 'package:docdoc/features/home/manager/cubit/home_state.dart';
import 'package:docdoc/core/utils/token_storage.dart';
import 'package:docdoc/core/utils/app_logger.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepoImpl _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  Future<void> fetchHome() async {
    emit(HomeLoading());
    AppLogger.bloc('Fetching home data...', tag: 'HomeCubit');
    try {
      final token = await TokenStorage.getToken();
      if (token == null || token.isEmpty) {
        AppLogger.warning('No token found — cannot fetch home', tag: 'HomeCubit');
        emit(HomeFailure('Not authenticated. Please login again.'));
        return;
      }
      final username = await TokenStorage.getUsername() ?? 'User';
      final homeData = await _homeRepo.fetchHome(token);
      AppLogger.info(
        'Home fetched — ${homeData.specializations.length} specializations, ${homeData.doctors.length} doctors',
        tag: 'HomeCubit',
      );
      emit(HomeSuccess(homeData: homeData, username: username));
    } catch (error) {
      AppLogger.error('Fetch home failed', tag: 'HomeCubit', exception: error);
      emit(HomeFailure(error.toString()));
    }
  }
}
