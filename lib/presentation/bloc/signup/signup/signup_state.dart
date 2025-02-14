part of 'signup_bloc.dart';

// Defining signup states
@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoadingState extends SignupState {}

final class SignupSuccessState extends SignupState {}

final class SignupErrorState extends SignupState {
  final String error;

  SignupErrorState({required this.error});
}
