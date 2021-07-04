part of '../Bloc/availability_bloc.dart';

abstract class AvailabilityEvent extends Equatable {
  const AvailabilityEvent();

  @override
  List<Object> get props => [];
}

class getAvailability extends AvailabilityEvent {}

class addAvailability extends AvailabilityEvent {
  final bool availability_slot1, availability_slot2, availability_slot3;
  final String selectedStartDate, selectedEndDate;
  addAvailability(this.availability_slot1, this.availability_slot2,
      this.availability_slot3, this.selectedStartDate, this.selectedEndDate);
}

class deleteAvailability extends AvailabilityEvent {
  final String data;

  deleteAvailability(this.data);
}
