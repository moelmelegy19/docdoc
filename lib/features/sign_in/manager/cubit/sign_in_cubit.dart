import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/features/sign_in/data/repos/sign_in_repo_impl.dart';
import 'package:docdoc/features/sign_in/manager/cubit/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepoImpl _signInRepo;
  
  SignInCubit(this._signInRepo) : super(SignInInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    if (formKey.currentState!.validate()) {
      emit(SignInLoading());
      try {
        final response = await _signInRepo.login(
          emailController.text,
          passwordController.text,
        );
        emit(SignInSuccess(response));
      } catch (error) {
        emit(SignInFailure(error.toString()));
      }
    }
  }
}