import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:docdoc/core/theme/colors.dart';
import 'package:docdoc/core/widgets/custom_text_field.dart';
import 'package:docdoc/core/widgets/custom_button.dart';
import 'package:docdoc/features/sign_up/manager/cubit/sign_up_cubit.dart';
import 'package:docdoc/features/sign_up/manager/cubit/sign_up_state.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // formKey lives here — NOT in the cubit — to avoid GlobalKey conflicts
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();

    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (prev, curr) =>
          curr is SignUpPasswordToggled ||
          curr is SignUpCountryChanged ||
          curr is SignUpGenderChanged ||
          curr is SignUpInitial,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              CustomTextField(
                hint: 'Name',
                controller: cubit.nameController,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),

              // Email
              CustomTextField(
                hint: 'Email',
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

              // Phone with Country Picker
              _PhoneField(cubit: cubit),
              const SizedBox(height: 16),

              // Gender Dropdown
              _GenderDropdown(cubit: cubit),
              const SizedBox(height: 16),

              // Password
              CustomTextField(
                hint: 'Password',
                isPassword: cubit.obscurePassword,
                controller: cubit.passwordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    cubit.obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.greyText,
                  ),
                  onPressed: cubit.togglePasswordVisibility,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 6) return 'At least 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Confirm Password
              CustomTextField(
                hint: 'Confirm Password',
                isPassword: cubit.obscureConfirm,
                controller: cubit.confirmPasswordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    cubit.obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.greyText,
                  ),
                  onPressed: cubit.toggleConfirmVisibility,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please confirm your password';
                  if (v != cubit.passwordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  if (state is SignUpLoading) {
                    return const SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: Center(child: CircularProgressIndicator(color: AppColors.primaryBlue)),
                    );
                  }
                  return CustomButton(
                    text: 'Create Account',
                    onPressed: () => cubit.emitRegisterStates(_formKey),
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

class _PhoneField extends StatelessWidget {
  final SignUpCubit cubit;
  const _PhoneField({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (p, c) => c is SignUpCountryChanged,
      builder: (context, state) {
        return Row(
          children: [
            // Country picker button
            GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  onSelect: (Country country) => cubit.updateCountry(country),
                  countryListTheme: CountryListThemeData(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    inputDecoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Start typing to search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lighterGrey, width: 1.2),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text(
                      cubit.selectedCountry.flagEmoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '+${cubit.selectedCountry.phoneCode}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down, color: AppColors.greyText),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextField(
                hint: 'Your number',
                controller: cubit.phoneController,
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Phone is required';
                  if (!RegExp(r'^[0-9]+$').hasMatch(v)) return 'Digits only';
                  return null;
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GenderDropdown extends StatelessWidget {
  final SignUpCubit cubit;
  const _GenderDropdown({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (p, c) => c is SignUpGenderChanged,
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          initialValue: cubit.selectedGender,
          decoration: InputDecoration(
            hintText: 'Select Gender',
            hintStyle: const TextStyle(color: AppColors.greyText, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.lighterGrey, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
          ),
          items: const [
            DropdownMenuItem(value: '0', child: Text('Male')),
            DropdownMenuItem(value: '1', child: Text('Female')),
          ],
          onChanged: (value) {
            if (value != null) cubit.updateGender(value);
          },
          validator: (v) => v == null ? 'Please select gender' : null,
        );
      },
    );
  }
}