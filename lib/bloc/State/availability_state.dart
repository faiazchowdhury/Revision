part of '../Bloc/availability_bloc.dart';

abstract class AvailabilityState extends Equatable {
  const AvailabilityState();

  @override
  List<Object> get props => [];
}

class AvailabilityInitial extends AvailabilityState {}

class AvailabilityLoading extends AvailabilityState {}

class AvailabilityLoaded extends AvailabilityState {}

class AvailabilityLoadedWithResponse extends AvailabilityState {
  final response;
  final int code;

  AvailabilityLoadedWithResponse(this.response, this.code);
}
