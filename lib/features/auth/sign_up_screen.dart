// import 'package:flutter/material.dart';
// import '../../core/theme/colors.dart';
// import '../../core/widgets/custom_button.dart';
// import '../../core/widgets/custom_text_field.dart';
// import 'widgets/social_login_section.dart';

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 40),
//               const Text('Create Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
//               const SizedBox(height: 8),
//               const Text(
//                 "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
//                 style: TextStyle(fontSize: 14, color: AppColors.greyText),
//               ),
//               const SizedBox(height: 36),
//               const CustomTextField(hint: 'Email'),
//               const CustomTextField(hint: 'Password', isPassword: true),
//               const CustomTextField(hint: 'Your number'),
//               const SizedBox(height: 24),
//               CustomButton(text: 'Create Account', onPressed: () {}),
//               const SizedBox(height: 40),
//               const SocialLoginSection(),
//               const SizedBox(height: 20),
//               Center(
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: RichText(
//                     text: const TextSpan(
//                       text: 'Already have an account yet? ',
//                       style: TextStyle(color: AppColors.greyText, fontSize: 12),
//                       children: [
//                         TextSpan(
//                           text: 'Sign In',
//                           style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }