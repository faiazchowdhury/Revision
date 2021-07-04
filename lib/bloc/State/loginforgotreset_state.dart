part of '../Bloc/loginforgotreset_bloc.dart';

abstract class LoginforgotresetState extends Equatable {
  const LoginforgotresetState();

  @override
  List<Object> get props => [];
}

class LoginforgotresetInitial extends LoginforgotresetState {}

class LoginforgotresetLoading extends LoginforgotresetState {}

class LoginforgotresetLoaded extends LoginforgotresetState {}

class LoginforgotresetLoadedwithResponse extends LoginforgotresetState {
  final response;
  final int code;

  LoginforgotresetLoadedwithResponse(this.response, this.code);
}
