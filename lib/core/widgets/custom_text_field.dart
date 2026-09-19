import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;

  const CustomTextField({super.key, required this.hint, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.greyText),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: isPassword ? const Icon(Icons.visibility_off, color: AppColors.greyText) : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.lighterGrey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1),
          ),
        ),
      ),
    );
  }
}