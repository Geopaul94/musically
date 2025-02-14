part of 'signup_bloc.dart';

// Defining signup events
@immutable
sealed class SignupEvent {}

final class UserSignupEvent extends SignupEvent {final UserModel userModel;

  UserSignupEvent({required this.userModel});}
