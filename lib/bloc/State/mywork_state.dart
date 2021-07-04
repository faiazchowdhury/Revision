part of '../Bloc/mywork_bloc.dart';

abstract class MyworkState extends Equatable {
  const MyworkState();

  @override
  List<Object> get props => [];
}

class MyworkInitial extends MyworkState {}

class MyworkLoading extends MyworkState {}

class MyworkLoaded extends MyworkState {}

class MyworkLoadedwithResponse extends MyworkState {
  final response;
  final int code;

  MyworkLoadedwithResponse(this.response, this.code);
}
