part of '../Bloc/registrationmethods_bloc.dart';

abstract class RegistrationmethodsState extends Equatable {
  const RegistrationmethodsState();

  @override
  List<Object> get props => [];
}

class RegistrationmethodsInitial extends RegistrationmethodsState {}

class RegistrationmethodsLoading extends RegistrationmethodsState {}

class RegistrationmethodsLoaded extends RegistrationmethodsState {
  final response;
  RegistrationmethodsLoaded(this.response);
}
