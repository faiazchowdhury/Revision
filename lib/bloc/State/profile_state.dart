part of '../Bloc/profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {}

class ProfileLoadedwithResponse extends ProfileState {
  final response;
  final int code;

  ProfileLoadedwithResponse(this.response, this.code);
}

class ProfileTokenStateLoaded extends ProfileState {
  final int code;
  ProfileTokenStateLoaded(this.code);
}
