import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/core/widgets/custom_text_field.dart';
import 'package:docdoc/core/widgets/custom_button.dart';
import 'package:docdoc/features/sign_in/manager/cubit/sign_in_cubit.dart';
import 'package:docdoc/features/sign_in/manager/cubit/sign_in_state.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // formKey lives here — NOT in the cubit — to avoid GlobalKey conflicts
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();

    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (prev, curr) =>
          curr is SignInPasswordToggled || curr is SignInInitial,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                hint: 'Email',
                isPassword: false,
                controller: cubit.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email is required';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: 'Password',
                isPassword: cubit.obscurePassword,
                controller: cubit.passwordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    cubit.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color(0xFF757575),
                  ),
                  onPressed: cubit.togglePasswordVisibility,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 6) return 'At least 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<SignInCubit, SignInState>(
                builder: (context, state) {
                  if (state is SignInLoading) {
                    return const SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF247CFF),
                        ),
                      ),
                    );
                  }
                  return CustomButton(
                    text: 'Login',
                    onPressed: () => cubit.emitLoginStates(_formKey),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}