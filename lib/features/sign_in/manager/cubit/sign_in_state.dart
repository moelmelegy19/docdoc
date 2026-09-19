abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final dynamic response;
  SignInSuccess(this.response);
}

class SignInFailure extends SignInState {
  final String errorMessage;
  SignInFailure(this.errorMessage);
}

class SignInPasswordToggled extends SignInState {
  final bool isObscured;
  SignInPasswordToggled(this.isObscured);
}