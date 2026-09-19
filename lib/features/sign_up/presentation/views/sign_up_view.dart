import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:docdoc/core/theme/colors.dart';
import 'package:docdoc/core/routing/route_names.dart';
import 'package:docdoc/core/utils/token_storage.dart';
import 'package:docdoc/features/auth/widgets/social_login_section.dart';
import 'package:docdoc/features/sign_up/manager/cubit/sign_up_cubit.dart';
import 'package:docdoc/features/sign_up/manager/cubit/sign_up_state.dart';
import 'package:docdoc/features/sign_up/presentation/widgets/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) async {
            if (state is SignUpSuccess) {
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
            if (state is SignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                    'Create Account',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.greyText,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 36),
                  const SignUpForm(),
                  const SizedBox(height: 40),
                  const SocialLoginSection(),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: AppColors.greyText,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
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
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
