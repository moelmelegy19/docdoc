import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:docdoc/features/sign_up/data/repos/sign_up_repo_impl.dart';
import 'package:docdoc/features/sign_up/manager/cubit/sign_up_state.dart';
import 'package:docdoc/core/utils/app_logger.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepoImpl _signUpRepo;

  SignUpCubit(this._signUpRepo) : super(SignUpInitial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirm => _obscureConfirm;

  Country _selectedCountry = Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Egypt',
    example: '1001234567',
    displayName: 'Egypt (EG) [+20]',
    displayNameNoCountryCode: 'Egypt (EG)',
    e164Key: '',
  );
  Country get selectedCountry => _selectedCountry;

  String _selectedGender = '0'; // 0 = Male, 1 = Female
  String get selectedGender => _selectedGender;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    emit(SignUpPasswordToggled(
      isObscured: _obscurePassword,
      isConfirmObscured: _obscureConfirm,
    ));
  }

  void toggleConfirmVisibility() {
    _obscureConfirm = !_obscureConfirm;
    emit(SignUpPasswordToggled(
      isObscured: _obscurePassword,
      isConfirmObscured: _obscureConfirm,
    ));
  }

  void updateCountry(Country country) {
    _selectedCountry = country;
    AppLogger.log('Country selected: ${country.name} (+${country.phoneCode})', tag: 'SignUpCubit');
    emit(SignUpCountryChanged(
      countryCode: country.phoneCode,
      flag: country.flagEmoji,
    ));
  }

  void updateGender(String gender) {
    _selectedGender = gender;
    AppLogger.log('Gender selected: $gender', tag: 'SignUpCubit');
    emit(SignUpGenderChanged(gender));
  }

  void emitRegisterStates(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      emit(SignUpLoading());
      final fullPhone = '+${_selectedCountry.phoneCode}${phoneController.text.trim()}';
      AppLogger.bloc(
        'Register attempt — email: ${emailController.text}, phone: $fullPhone',
        tag: 'SignUpCubit',
      );
      try {
        final response = await _signUpRepo.register(
          nameController.text.trim(),
          emailController.text.trim(),
          fullPhone,
          _selectedGender,
          passwordController.text,
          confirmPasswordController.text,
        );
        AppLogger.info('Register success — response: $response', tag: 'SignUpCubit');
        emit(SignUpSuccess(response));
      } catch (error) {
        AppLogger.error('Register failed', tag: 'SignUpCubit', exception: error);
        emit(SignUpFailure(error.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}