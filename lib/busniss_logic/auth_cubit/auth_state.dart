abstract class AuthState{}

class AuthInitial extends AuthState{}

class LoginSuccess extends AuthState{}

class LoginLoading extends AuthState{}

class LoginFailure extends AuthState{
  String msgErorr;
  LoginFailure({required this.msgErorr});
}

class RegisterSuccess extends AuthState{}

class RegisterLoading extends AuthState{}

class RegisterFailure extends AuthState{
  String msgErorr;
  RegisterFailure({required this.msgErorr});
}