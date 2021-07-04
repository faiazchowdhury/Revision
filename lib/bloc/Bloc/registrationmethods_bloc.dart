import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revised_quickassist/Model/authToken.dart';
import 'package:revised_quickassist/Model/profilePicture.dart';
import 'package:revised_quickassist/Model/registrationInformation.dart';
import 'package:http/http.dart' as http;
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:stripe_payment/stripe_payment.dart';

part '../Event/registrationmethods_event.dart';
part '../State/registrationmethods_state.dart';

class RegistrationmethodsBloc
    extends Bloc<RegistrationmethodsEvent, RegistrationmethodsState> {
  RegistrationmethodsBloc() : super(RegistrationmethodsInitial());

  @override
  Stream<RegistrationmethodsState> mapEventToState(
    RegistrationmethodsEvent event,
  ) async* {
    if (event is emailCheckRegistration) {
      yield RegistrationmethodsLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/account/email/?email=" + event.email);
      if (response.statusCode == 200) {
        registrationInformation.setEmailPassNameFlag(
            event.email, event.pass, event.name, "${event.flag}");
      }
      yield RegistrationmethodsLoaded(response);
    }

    if (event is getCityNames) {
      yield RegistrationmethodsLoading();
      var response =
          await http.get("${baseUrl.getUrl}/v1/api/app/account/cities/");
      var city = json.decode(response.body);
      yield RegistrationmethodsLoaded(city);
    }

    if (event is getServicesList) {
      yield RegistrationmethodsLoading();
      var response =
          await http.get("${baseUrl.getUrl}/v1/api/app/account/services/");
      var services = json.decode(response.body);
      yield RegistrationmethodsLoaded(services);
    }

    if (event is convertListToString) {
      String convertedString = "";
      for (int i = 0; i < event.content.length; i++) {
        if (convertedString == "") {
          convertedString = convertedString + event.content[i];
        } else {
          convertedString = convertedString + "," + event.content[i];
        }
      }
      registrationInformation.setServices(convertedString);
    }

    if (event is uploadImage) {
      PickedFile image = await ImagePicker()
          .getImage(source: ImageSource.gallery, imageQuality: 100);
      profilePicture.setImage(File(image.path));
      yield RegistrationmethodsLoaded(null);
    }

    if (event is addPaymentMethodAndRegister) {
      String temp = "";
      yield RegistrationmethodsLoading();
      StripePayment.setOptions(StripeOptions(
          publishableKey: "", merchantId: "Test", androidPayMode: 'test'));
      await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
          card: CreditCard(
            name: event.noc,
            number: event.cn,
            cvc: event.ccv,
            expMonth: int.parse(event.exp.split("/")[0]),
            expYear: int.parse(event.exp.split("/")[1]),
          ),
        ),
      ).then((paymentMethod) {
        registrationInformation.setPaymentMethodId(paymentMethod.id.toString());
        temp = paymentMethod.id.toString();
        snackbar(event.scaffoldKey, "Processing!").showSnackbar();
      }).catchError((error) =>
          snackbar(event.scaffoldKey, error.toString().split(",")[1])
              .showSnackbar());
      if (temp != "") {
        var response = await http
            .post('${baseUrl.getUrl}/v1/api/app/account/register/', body: {
          "email": registrationInformation.getEmail,
          "password": registrationInformation.getPass,
          "full_name": registrationInformation.getName,
          "zip_code": registrationInformation.getZip,
          "country": registrationInformation.getCountry,
          "phone_number": registrationInformation.getPhoneNumber,
          "city": registrationInformation.getCity,
          "service_list": registrationInformation.getServices,
          "social_security_number": registrationInformation.getSsn,
          "date_of_birth": registrationInformation.getDOB,
          "street_number": registrationInformation.getStreetnn,
          "apartment": registrationInformation.getAppsuits,
          "city_verify": registrationInformation.getLivingCity,
          "state": registrationInformation.getState,
          "zip_code_verify": registrationInformation.getZip,
          "checkbox": registrationInformation.getCheckBox,
          "payment_method_id": registrationInformation.getPaymentMethodId,
          "vehicle": registrationInformation.getVehicle,
        });
        var res = json.decode(response.body);
        if (response.statusCode == 200) {
          authToken.setToken(res['token']);
          Map<String, String> headers = {
            "Authorization": "Token " + authToken.getToken
          };
          var request = http.MultipartRequest(
              'POST',
              Uri.parse(
                  '${baseUrl.getUrl}/v1/api/app/account/profilepicture/'));
          request.files.add(await http.MultipartFile.fromPath(
              'profile_photo', profilePicture.getImg.path));
          request.headers.addAll(headers);
          res = await request.send();
          yield RegistrationmethodsLoaded(res);
        } else {
          yield RegistrationmethodsLoaded(response);
        }
      } else {
        yield RegistrationmethodsLoaded(null);
      }
    }
  }
}
