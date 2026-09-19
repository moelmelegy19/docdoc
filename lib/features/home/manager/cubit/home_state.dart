import 'package:docdoc/features/home/data/models/home_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeModel homeData;
  final String username;
  HomeSuccess({required this.homeData, required this.username});
}

class HomeFailure extends HomeState {
  final String errorMessage;
  HomeFailure(this.errorMessage);
}
