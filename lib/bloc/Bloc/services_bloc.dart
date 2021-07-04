import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:revised_quickassist/Model/authToken.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:revised_quickassist/Model/allServicesList.dart';
import 'package:revised_quickassist/Model/serviceCategoryList.dart';
import 'package:revised_quickassist/Model/serviceProviderInfo.dart';
import 'package:revised_quickassist/Model/serviceProviderReviewsList.dart';
import 'package:revised_quickassist/Model/serviceProviderLoaction.dart';

part '../Event/services_event.dart';
part '../State/services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial());

  @override
  Stream<ServicesState> mapEventToState(
    ServicesEvent event,
  ) async* {
    if (event is getServicesList) {
      yield ServicesLoading();
      var response = await http.get("${baseUrl.getUrl}/v1/api/app/services/",
          headers: {"Authorization": "Token " + authToken.getToken});
      allServicesList(json.decode(response.body), response.statusCode);
      yield ServicesLoaded();
    }

    if (event is getServiceProviderReviews) {
      yield ServicesLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/account/reviews/",
          headers: {"Authorization": "Token " + authToken.getToken});
      serviceProviderReviewsList(
          json.decode(response.body), response.statusCode);
      yield ServicesLoaded();
    }

    if (event is getServiceProviderLocation) {
      yield ServicesLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/services/range/",
          headers: {"Authorization": "Token " + authToken.getToken});
      serviceProviderLoaction(json.decode(response.body), response.statusCode);
      yield ServicesLoaded();
    }

    if (event is saveServiceProviderLocation) {
      yield ServicesLoading();
      var response = await http.post(
        '${baseUrl.getUrl}/v1/api/app/services/range/',
        headers: {"Authorization": "Token " + authToken.getToken},
        body: {
          "lattitude": "${event.lat}",
          "longtitude": "${event.long}",
          "radius": "${event.rad}",
          "name": event.locationName
        },
      );
      if (response.statusCode == 200) {
        await http.get("${baseUrl.getUrl}/v1/api/app/services/range/",
            headers: {"Authorization": "Token " + authToken.getToken});
        serviceProviderInfo.setCheckLocation = true;
        serviceProviderLoaction(
            json.decode(response.body), response.statusCode);
      }
      yield ServicesLoadedwithResponse(response, response.statusCode);
    }

    if (event is getServiceCategoryList) {
      yield ServicesLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/services/list/",
          headers: {"Authorization": "Token " + authToken.getToken});
      var serviceListExtractor = json.decode(response.body);
      List<String> services = [];
      for (int i = 0; i < serviceListExtractor.length; i++) {
        services.add(serviceListExtractor[i]['name']);
      }
      serviceCategoryList(
          json.decode(response.body), response.statusCode, services);

      yield ServicesLoaded();
    }

    if (event is addService) {
      yield ServicesLoading();
      var response = await http.post(
        '${baseUrl.getUrl}/v1/api/app/services/',
        headers: {"Authorization": "Token " + authToken.getToken},
        body: {
          "category_name": event.serviceType,
          "description": event.desc,
          "rate": "${event.rate}"
        },
      );
      if (response.statusCode == 200) {
        var res = await http.get("${baseUrl.getUrl}/v1/api/app/services/",
            headers: {"Authorization": "Token " + authToken.getToken});
        serviceProviderInfo.setCheckService = true;
        allServicesList(json.decode(res.body), res.statusCode);
      }
      yield ServicesLoadedwithResponse(response, response.statusCode);
    }

    if (event is editService) {
      yield ServicesLoading();
      var response = await http.post(
        '${baseUrl.getUrl}/v1/api/app/services/${event.id}/',
        headers: {"Authorization": "Token " + authToken.getToken},
        body: {
          "category_name": event.serviceType,
          "description": event.desc,
          "rate": "${event.rate}"
        },
      );
      if (response.statusCode == 200) {
        var res = await http.get("${baseUrl.getUrl}/v1/api/app/services/",
            headers: {"Authorization": "Token " + authToken.getToken});
        allServicesList(json.decode(res.body), res.statusCode);
      }
      yield ServicesLoadedwithResponse(response, response.statusCode);
    }

    if (event is deleteService) {
      yield ServicesLoading();
      var response = await http.delete(
        "${baseUrl.getUrl}/v1/api/app/services/${event.id}/",
        headers: {"Authorization": "Token " + authToken.getToken},
      );
      if (response.statusCode == 200) {
        var res = await http.get("${baseUrl.getUrl}/v1/api/app/services/",
            headers: {"Authorization": "Token " + authToken.getToken});
        allServicesList(json.decode(res.body), res.statusCode);
      }
      yield ServicesLoadedwithResponse(response, response.statusCode);
    }
  }
}
