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