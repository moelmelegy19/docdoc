import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/app_images.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Or sign in with', style: TextStyle(color: Colors.grey.shade400)),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(AppImages.google),
            const SizedBox(width: 20),
            _buildSocialIcon(AppImages.facebook),
            const SizedBox(width: 20),
            _buildSocialIcon(AppImages.apple),
          ],
        ),
        const SizedBox(height: 32),
        const Text(
          'By logging, you agree to our Terms & Conditions and PrivacyPolicy.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: AppColors.greyText),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String iconPath) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.lighterGrey,
      child: Image.asset(iconPath, width: 24, height: 24),
    );
  }
}