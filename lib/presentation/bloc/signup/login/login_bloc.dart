import 'package:bloc/bloc.dart';
import 'package:musically/data/repository/authentication/auth_service.dart';
import 'package:musically/presentation/bloc/signup/login/login_event.dart';
import 'package:musically/presentation/bloc/signup/login/login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<UserLoginEvent>(_onLoginSubmitted);
    on<UserGoogleLoginEvent>(_onGoogleLoginSubmitted); 
  }

  Future<void> _onLoginSubmitted(UserLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      await AuthService().loginWithEmailAndPassword(event.email, event.password);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(error: e.toString())); // Capture and pass error
    }
  }

  Future<void> _onGoogleLoginSubmitted(UserGoogleLoginEvent event, Emitter<LoginState> emit) async {
    emit(GoogleLoginLoadingState());
    try {
      // Assume `AuthService` has a method for Google sign-in
      await AuthService().loginWithGoogle(); 
      emit(GoogleLoginSuccessState());
    } catch (e) {
      emit(GoogleLoginErrorState(error: e.toString())); // Capture and pass error
    }
  }
}