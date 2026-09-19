import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import 'sign_up_screen.dart';
import 'widgets/social_login_section.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text('Welcome Back', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
              const SizedBox(height: 8),
              const Text(
                "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
                style: TextStyle(fontSize: 14, color: AppColors.greyText),
              ),
              const SizedBox(height: 36),
              const CustomTextField(hint: 'Email'),
              const CustomTextField(hint: 'Password', isPassword: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (val) {}),
                      const Text('Remember me', style: TextStyle(color: AppColors.greyText, fontSize: 12)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?', style: TextStyle(color: AppColors.primaryBlue, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomButton(text: 'Login', onPressed: () {}),
              const SizedBox(height: 40),
              const SocialLoginSection(),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Don't have an account yet? ",
                      style: TextStyle(color: AppColors.greyText, fontSize: 12),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}