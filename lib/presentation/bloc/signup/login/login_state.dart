
sealed class LoginState {}

class LoginInitial extends LoginState {}


class LoginLoadingState extends LoginState {}


class LoginSuccessState extends LoginState {}


class LoginErrorState extends LoginState {

  final String error;


  LoginErrorState({required this.error});

}


class GoogleLoginLoadingState extends LoginState {}

class GoogleLoginSuccessState extends LoginState {}

class GoogleLoginErrorState extends LoginState {
  final String error;

  GoogleLoginErrorState({required this.error});
}