import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/core/widgets/custom_text_field.dart';
import 'package:docdoc/core/widgets/custom_button.dart';
import 'package:docdoc/features/sign_in/manager/cubit/sign_in_cubit.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          CustomTextField(
            hint: 'Email',
            isPassword: false,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'Password',
            isPassword: true,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Login',
            onPressed: () {
              cubit.emitLoginStates();
            },
          ),
        ],
      ),
    );
  }
}