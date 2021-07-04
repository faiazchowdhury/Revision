import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:revised_quickassist/Model/authToken.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:revised_quickassist/Model/availabilityListResponse.dart';
import 'package:revised_quickassist/Model/serviceProviderInfo.dart';

part '../Event/availability_event.dart';
part '../State/availability_state.dart';

class AvailabilityBloc extends Bloc<AvailabilityEvent, AvailabilityState> {
  AvailabilityBloc() : super(AvailabilityInitial());

  @override
  Stream<AvailabilityState> mapEventToState(
    AvailabilityEvent event,
  ) async* {
    if (event is getAvailability) {
      yield AvailabilityLoading();
      List<String> startendDate = [];
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/services/availability/",
          headers: {"Authorization": "Token " + authToken.getToken});
      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        for (int index = 0; index < res.length; index++) {
          startendDate.add(
              res[index]['starting_date'] + " - " + res[index]['ending_date']);
        }
      }
      availabilityListResponse(res, response.statusCode, startendDate);
      yield AvailabilityLoaded();
    }

    if (event is addAvailability) {
      yield AvailabilityLoading();
      var response = await http.post(
        '${baseUrl.getUrl}/v1/api/app/services/availability/',
        headers: {"Authorization": "Token " + authToken.getToken},
        body: {
          "shift1": "${event.availability_slot1}",
          "shift2": "${event.availability_slot2}",
          "shift3": "${event.availability_slot3}",
          "start_date": event.selectedStartDate,
          "end_date": event.selectedEndDate
        },
      );
      if (response.statusCode == 200) {
        List<String> startendDate = [];
        response = await http.get(
            "${baseUrl.getUrl}/v1/api/app/services/availability/",
            headers: {"Authorization": "Token " + authToken.getToken});
        var res = json.decode(response.body);
        if (response.statusCode == 200) {
          for (int index = 0; index < res.length; index++) {
            startendDate.add(res[index]['starting_date'] +
                " - " +
                res[index]['ending_date']);
          }
        }
        serviceProviderInfo.setCheckAvailability = true;
        availabilityListResponse(res, response.statusCode, startendDate);
      }
      yield AvailabilityLoadedWithResponse(response, response.statusCode);
    }

    if (event is deleteAvailability) {
      yield AvailabilityLoading();
      var response = await http.delete(
          "${baseUrl.getUrl}/v1/api/app/services/availability/${event.data}/",
          headers: {"Authorization": "Token " + authToken.getToken});
      if (response.statusCode == 200) {
        List<String> startendDate = [];
        response = await http.get(
            "${baseUrl.getUrl}/v1/api/app/services/availability/",
            headers: {"Authorization": "Token " + authToken.getToken});
        var res = json.decode(response.body);
        if (response.statusCode == 200) {
          for (int index = 0; index < res.length; index++) {
            startendDate.add(res[index]['starting_date'] +
                " - " +
                res[index]['ending_date']);
          }
        }
        availabilityListResponse(res, response.statusCode, startendDate);
      }
      yield AvailabilityLoadedWithResponse(response, response.statusCode);
    }
  }
}
