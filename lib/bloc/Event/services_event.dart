part of '../Bloc/services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  List<Object> get props => [];
}

class getServicesList extends ServicesEvent {}

class getServiceProviderReviews extends ServicesEvent {}

class getServiceProviderLocation extends ServicesEvent {}

class saveServiceProviderLocation extends ServicesEvent {
  final double lat, long, rad;
  final String locationName;

  saveServiceProviderLocation(this.lat, this.long, this.rad, this.locationName);
}

class getServiceCategoryList extends ServicesEvent {}

class addService extends ServicesEvent {
  final String serviceType, desc;
  final double rate;

  addService(this.serviceType, this.desc, this.rate);
}

class editService extends ServicesEvent {
  final String id, serviceType, desc;
  final double rate;

  editService(this.id, this.serviceType, this.desc, this.rate);
}

class deleteService extends ServicesEvent {
  final String id;

  deleteService(this.id);
}
