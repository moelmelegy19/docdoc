import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:docdoc/core/theme/colors.dart';
import 'package:docdoc/core/routing/route_names.dart';
import 'package:docdoc/core/utils/token_storage.dart';
import 'package:docdoc/features/auth/widgets/social_login_section.dart';
import 'package:docdoc/features/sign_in/manager/cubit/sign_in_cubit.dart';
import 'package:docdoc/features/sign_in/manager/cubit/sign_in_state.dart';
import 'package:docdoc/features/sign_in/presentation/widgets/sign_in_form.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) async {
            if (state is SignInSuccess) {
              final data = state.response['data'];
              if (data != null) {
                await TokenStorage.saveToken(
                  data['token'] ?? '',
                  username: data['username'],
                );
              }
              if (!context.mounted) return;
              context.go(RouteNames.home);
            }
            if (state is SignInFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  content: Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
                    style: TextStyle(fontSize: 14, color: AppColors.greyText, height: 1.5),
                  ),
                  const SizedBox(height: 36),
                  const SignInForm(),
                  const SizedBox(height: 40),
                  const SocialLoginSection(),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => context.push(RouteNames.signUp),
                      child: RichText(
                        text: const TextSpan(
                          text: "Don't have an account yet? ",
                          style: TextStyle(color: AppColors.greyText, fontSize: 13),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
