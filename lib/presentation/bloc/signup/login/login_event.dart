
sealed class LoginEvent {}

class UserLoginEvent extends LoginEvent {

  final String email;

  final String password;


  UserLoginEvent({required this.email, required this.password});
}
class UserGoogleLoginEvent extends LoginEvent {


}