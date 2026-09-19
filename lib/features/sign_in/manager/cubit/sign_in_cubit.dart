import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/features/sign_in/data/repos/sign_in_repo_impl.dart';
import 'package:docdoc/features/sign_in/manager/cubit/sign_in_state.dart';
import 'package:docdoc/core/utils/app_logger.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepoImpl _signInRepo;

  SignInCubit(this._signInRepo) : super(SignInInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    emit(SignInPasswordToggled(_obscurePassword));
  }

  void emitLoginStates(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      emit(SignInLoading());
      AppLogger.bloc('Login attempt — email: ${emailController.text}', tag: 'SignInCubit');
      try {
        final response = await _signInRepo.login(
          emailController.text,
          passwordController.text,
        );
        AppLogger.info('Login success — response: $response', tag: 'SignInCubit');
        emit(SignInSuccess(response));
      } catch (error) {
        AppLogger.error('Login failed', tag: 'SignInCubit', exception: error);
        emit(SignInFailure(error.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}