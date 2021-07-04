part of '../Bloc/registrationmethods_bloc.dart';

abstract class RegistrationmethodsEvent extends Equatable {
  const RegistrationmethodsEvent();

  @override
  List<Object> get props => [];
}

class emailCheckRegistration extends RegistrationmethodsEvent {
  final String email;
  final String pass;
  final String name;
  final bool flag;
  emailCheckRegistration(this.email, this.pass, this.name, this.flag);
}

class getCityNames extends RegistrationmethodsEvent {}

class getServicesList extends RegistrationmethodsEvent {}

class convertListToString extends RegistrationmethodsEvent {
  final List<String> content;
  convertListToString(this.content);
}

class uploadImage extends RegistrationmethodsEvent {}

class addPaymentMethodAndRegister extends RegistrationmethodsEvent {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String ccv, cn, exp, noc;

  addPaymentMethodAndRegister(
      this.scaffoldKey, this.ccv, this.cn, this.exp, this.noc);
}
