import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/core/widgets/custom_text_field.dart';
import 'package:docdoc/core/widgets/custom_button.dart';
import 'package:docdoc/features/sign_up/manager/cubit/sign_up_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          CustomTextField(
            hint: 'Name',
            isPassword: false,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'Email',
            isPassword: false,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'Phone',
            isPassword: false,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'Password',
            isPassword: true,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'Confirm Password',
            isPassword: true,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Create Account',
            onPressed: () {
              cubit.emitRegisterStates();
            },
          ),
        ],
      ),
    );
  }
}