import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musically/data/models/user_data_model.dart';
import 'package:musically/data/repository/authentication/auth_service.dart';

// Event definition
part 'signup_event.dart';

// State definition
part 'signup_state.dart';

// SignupBloc implementation
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    // Handling the user signup event
    on<UserSignupEvent>((event, emit) async {
      emit(SignupLoadingState());

      try {
     await AuthService().signup(event.userModel);
        // On success, emit the success state
        emit(SignupSuccessState());
      } catch (error) {
        // On error, emit the error state with the error message
        emit(SignupErrorState(error: error.toString()));
      }
    });
  }
}
