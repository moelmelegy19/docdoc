import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/features/sign_up/data/repos/sign_up_repo_impl.dart';
import 'package:docdoc/features/sign_up/manager/cubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepoImpl _signUpRepo;
  
  SignUpCubit(this._signUpRepo) : super(SignUpInitial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void emitRegisterStates() async {
    if (formKey.currentState!.validate()) {
      emit(SignUpLoading());
      try {
        final response = await _signUpRepo.register(
          nameController.text,
          emailController.text,
          phoneController.text,
          passwordController.text,
          confirmPasswordController.text,
        );
        emit(SignUpSuccess(response));
      } catch (error) {
        emit(SignUpFailure(error.toString()));
      }
    }
  }
}