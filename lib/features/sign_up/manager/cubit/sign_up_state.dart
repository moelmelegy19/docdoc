abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final dynamic response;
  SignUpSuccess(this.response);
}

class SignUpFailure extends SignUpState {
  final String errorMessage;
  SignUpFailure(this.errorMessage);
}

class SignUpPasswordToggled extends SignUpState {
  final bool isObscured;
  final bool isConfirmObscured;
  SignUpPasswordToggled({required this.isObscured, required this.isConfirmObscured});
}

class SignUpCountryChanged extends SignUpState {
  final String countryCode;
  final String flag;
  SignUpCountryChanged({required this.countryCode, required this.flag});
}

class SignUpGenderChanged extends SignUpState {
  final String gender;
  SignUpGenderChanged(this.gender);
}