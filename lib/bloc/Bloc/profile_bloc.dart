import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:revised_quickassist/Model/authToken.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:revised_quickassist/Model/serviceProviderInfo.dart';

part '../Event/profile_event.dart';
part '../State/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is getInfo) {
      yield ProfileLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/account/home/",
          headers: {"Authorization": "Token " + authToken.getToken});
      serviceProviderInfo.setApprovalCode = response.statusCode;
      var res = json.decode(response.body);
      if (response.statusCode == 403) {
        serviceProviderInfo.setName =
            json.decode(response.body)['name'].toString();
      } else {
        try {
          serviceProviderInfo.setName =
              json.decode(response.body)['name'].toString();
        } catch (e) {
          serviceProviderInfo.setName =
              json.decode(response.body)[0]['worker'].toString();
        }

        try {
          serviceProviderInfo.setVisible =
              !res['range'] || !res['availability'] || !res['service'];
          serviceProviderInfo.setCheckLocation = res['range'];
          serviceProviderInfo.setCheckAvailability = res['availability'];
          serviceProviderInfo.setCheckService = res['service'];
          serviceProviderInfo.setNoWork = false;
        } catch (e) {
          try {
            String test = res['name'].toString().split(" ")[0];
            serviceProviderInfo.setNoWork = true;
          } catch (err) {
            serviceProviderInfo.setNoWork = false;
            for (int i = 0; i < res.length; i++) {
              if (DateFormat('dd-MM-yyyy').format(DateTime.now()) ==
                  DateFormat('dd-MM-yyyy').format(
                      DateTime.parse(res[i]['date_selected'].toString()))) {
                if (serviceProviderInfo.tScheduleTime.isEmpty) {
                  serviceProviderInfo.setTScheduleTime = [
                    '${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(res[i]['starttime_selected']))} - ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(res[i]['endtime_selected']))}'
                  ];
                } else {
                  serviceProviderInfo.tScheduleTime.add(
                      '${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(res[i]['starttime_selected']))} - ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(res[i]['endtime_selected']))}');
                }
                if (serviceProviderInfo.tScheduleType.isEmpty) {
                  serviceProviderInfo.setTScheduleType = [
                    '${res[i]['service_category']}'
                  ];
                } else {
                  serviceProviderInfo.tScheduleType
                      .add('${res[i]['service_category']}');
                }
              } else {
                if (DateFormat('dd-MM-yyyy')
                        .format(DateTime.now().add(Duration(days: 1))) ==
                    DateFormat('dd-MM-yyyy').format(
                        DateTime.parse(res[i]['date_selected'].toString()))) {
                  if (serviceProviderInfo.nScheduleTime.isEmpty) {
                    serviceProviderInfo.setNScheduleTime = [
                      '${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(res[i]['starttime_selected']))} - ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(res[i]['endtime_selected']))}'
                    ];
                  } else {
                    serviceProviderInfo.nScheduleTime.add(
                        '${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(res[i]['starttime_selected']))} - ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(res[i]['endtime_selected']))}');
                  }
                  if (serviceProviderInfo.nScheduleType.isEmpty) {
                    serviceProviderInfo.setNScheduleType = [
                      '${res[i]['service_category']}'
                    ];
                  } else {
                    serviceProviderInfo.nScheduleType
                        .add('${res[i]['service_category']}');
                  }
                  if (serviceProviderInfo.nScheduleDate.isEmpty) {
                    serviceProviderInfo.setNScheduleDate = [
                      '${DateFormat('dd/MM/yyyy').format(DateTime.parse(res[i]['date_selected'].toString()))}'
                    ];
                  } else {
                    serviceProviderInfo.nScheduleDate.add(
                        '${DateFormat('dd/MM/yyyy').format(DateTime.parse(res[i]['date_selected'].toString()))}');
                  }
                }
              }
            }
          }
        }
      }
      yield ProfileLoadedwithResponse(response, response.statusCode);
    }

    if (event is getServiceProviderPicture) {
      yield ProfileLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/account/profilepicture/",
          headers: {"Authorization": "Token " + authToken.getToken});
      serviceProviderInfo.setImg =
          json.decode(response.body)['profile_photo'].toString();
      yield ProfileLoadedwithResponse(null, 200);
    }

    if (event is getToken) {
      yield ProfileLoading();
      final storage = new FlutterSecureStorage();
      if (await storage.containsKey(key: 'token')) {
        authToken.setToken(await storage.read(key: 'token'));
        yield ProfileTokenStateLoaded(200);
      } else {
        yield ProfileTokenStateLoaded(500);
      }
    }

    if (event is changePass) {
      yield ProfileLoading();
      var response = await http.post(
          "${baseUrl.getUrl}/v1/api/app/account/password/change/",
          headers: {
            "Authorization": "Token " + authToken.getToken
          },
          body: {
            "old_password": event.oldPass,
            "new_password": event.newPass,
          });
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is getPhoneNumber) {
      yield ProfileLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/account/phone/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is changePhoneNumber) {
      yield ProfileLoading();
      var response = await http
          .post("${baseUrl.getUrl}/v1/api/app/account/phone/", headers: {
        "Authorization": "Token " + authToken.getToken
      }, body: {
        "new_number": event.number,
      });
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is getPersonalInfo) {
      yield ProfileLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/account/aboutme/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is changePersonalInfo) {
      yield ProfileLoading();
      var response = await http.post(
          "${baseUrl.getUrl}/v1/api/app/account/aboutme/",
          headers: {"Authorization": "Token " + authToken.getToken},
          body: {"about_me": event.aboutMe, "vehicle": event.vehicleType});
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is getBankInfo) {
      yield ProfileLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/account/bank/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is getBalance) {
      yield ProfileLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/account/balance/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is withdrawBalance) {
      yield ProfileLoading();
      var response = await http.post(
          "${baseUrl.getUrl}/v1/api/app/account/withdraw/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is addPayment) {
      yield ProfileLoading();
      var response = await http
          .post("${baseUrl.getUrl}/v1/api/app/account/bank/", headers: {
        "Authorization": "Token " + authToken.getToken
      }, body: {
        "full_name": event.name,
        "phone_number": event.pNumber,
        "email": event.email,
        "bank_name": event.bankName,
        "bank_account_number": event.accountNumber,
        "routing_code": event.abaCode,
        "address": event.address
      });
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is deleteBankInfo) {
      yield ProfileLoading();
      var response = await http.delete(
        "${baseUrl.getUrl}/v1/api/app/account/bank/",
        headers: {"Authorization": "Token " + authToken.getToken},
      );
      response = await http.get("${baseUrl.getUrl}/v1/api/app/account/bank/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is getTransactionHistory) {
      yield ProfileLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/account/withdraw/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is getNotification) {
      yield ProfileLoading();
      Uri url = Uri.parse("${baseUrl.getUrl}/v1/api/app/account/notification/");
      var response = await http
          .get(url, headers: {"Authorization": "Token " + authToken.getToken});
      yield ProfileLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }
  }
}
