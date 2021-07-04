part of '../Bloc/profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class getInfo extends ProfileEvent {}

class getToken extends ProfileEvent {}

class getServiceProviderPicture extends ProfileEvent {}

class changePass extends ProfileEvent {
  final String oldPass, newPass;

  changePass(this.oldPass, this.newPass);
}

class getPhoneNumber extends ProfileEvent {}

class changePhoneNumber extends ProfileEvent {
  final String number;

  changePhoneNumber(this.number);
}

class getPersonalInfo extends ProfileEvent {}

class changePersonalInfo extends ProfileEvent {
  final String aboutMe, vehicleType;

  changePersonalInfo(this.aboutMe, this.vehicleType);
}

class getBankInfo extends ProfileEvent {}

class getBalance extends ProfileEvent {}

class withdrawBalance extends ProfileEvent {}

class deleteBankInfo extends ProfileEvent {}

class addPayment extends ProfileEvent {
  final String abaCode, name, pNumber, address, bankName, accountNumber, email;

  addPayment(this.abaCode, this.name, this.pNumber, this.address, this.bankName,
      this.accountNumber, this.email);
}

class getTransactionHistory extends ProfileEvent {}

class getNotification extends ProfileEvent {}
