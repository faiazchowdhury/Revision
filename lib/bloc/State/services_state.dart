part of '../Bloc/services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object> get props => [];
}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {}

class ServicesLoadedwithResponse extends ServicesState {
  final response;
  final int code;

  ServicesLoadedwithResponse(this.response, this.code);
}
