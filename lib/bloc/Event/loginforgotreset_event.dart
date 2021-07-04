part of '../Bloc/loginforgotreset_bloc.dart';

abstract class LoginforgotresetEvent extends Equatable {
  const LoginforgotresetEvent();

  @override
  List<Object> get props => [];
}

class checkLogin extends LoginforgotresetEvent {
  final String email, pass;

  checkLogin(this.email, this.pass);
}

class forgotPassword extends LoginforgotresetEvent {
  final String email;

  forgotPassword(this.email);
}

class resetPassword extends LoginforgotresetEvent {
  final String email,code,password;

  resetPassword(this.email, this.code, this.password);
}


