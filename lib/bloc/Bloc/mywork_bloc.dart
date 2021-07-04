import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:revised_quickassist/Model/authToken.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:revised_quickassist/Model/activeContracts.dart';
import 'package:revised_quickassist/Model/listOfInfo.dart';

import 'package:revised_quickassist/Model/pastContracts.dart';

part '../Event/mywork_event.dart';
part '../State/mywork_state.dart';

class MyworkBloc extends Bloc<MyworkEvent, MyworkState> {
  MyworkBloc() : super(MyworkInitial());

  @override
  Stream<MyworkState> mapEventToState(
    MyworkEvent event,
  ) async* {
    if (event is getActiveWork) {
      yield MyworkLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/contracts/active/",
          headers: {"Authorization": "Token " + authToken.getToken});
      activeContracts(json.decode(response.body), response.statusCode);
      yield MyworkLoaded();
    }

    if (event is getPastWork) {
      yield MyworkLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/contracts/past/",
          headers: {"Authorization": "Token " + authToken.getToken});
      pastContracts(json.decode(response.body), response.statusCode);
      yield MyworkLoaded();
    }

    if (event is getWorkerDetails) {
      yield MyworkLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/contracts/${event.id}/client/profile/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield MyworkLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is getWorkerReviews) {
      yield MyworkLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/contracts/review/${event.id}/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield MyworkLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is getWorkDetails) {
      yield MyworkLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/contracts/${event.id}/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield MyworkLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }
    if (event is getSelectedClientReview) {
      yield MyworkLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/account/reviews?contract_id=${event.id}",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield MyworkLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is markContractAsCompleted) {
      var response = await http.post(
          "${baseUrl.getUrl}/v1/api/app/contracts/${event.id}/seen/",
          headers: {"Authorization": "Token " + authToken.getToken});
      response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/contracts/active/",
          headers: {"Authorization": "Token " + authToken.getToken});
      activeContracts(json.decode(response.body), response.statusCode);
    }

    if (event is getClarification) {
      yield MyworkLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/contracts/${event.id}/conversation/",
          headers: {"Authorization": "Token " + authToken.getToken});
      print(json.decode(response.body));
      yield MyworkLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is postClarification) {
      yield MyworkLoading();
      var response = await http.post(
          "${baseUrl.getUrl}/v1/api/app/contracts/${event.id}/conversation/",
          headers: {
            "Authorization": "Token " + authToken.getToken
          },
          body: {
            "text": event.text,
          });
      response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/contracts/${event.id}/conversation/",
          headers: {"Authorization": "Token " + authToken.getToken});
      yield MyworkLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is getCancelList) {
      yield MyworkLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/contracts/cancel/list/",
          headers: {"Authorization": "Token " + authToken.getToken});
      listOfInfo.setCancelList = json.decode(response.body)['feedback'];
      yield MyworkLoaded();
    }

    if (event is cancelContract) {
      yield MyworkLoading();
      var response = await http.post(
          "${baseUrl.getUrl}/v1/api/app/contracts/${event.contractID}/cancel/",
          headers: {
            "Authorization": "Token " + authToken.getToken
          },
          body: {
            "reason": event.cancelHint,
            "description": event.cancelDetails,
          });
      if (response.statusCode == 200) {
        var res = await http.get(
            "${baseUrl.getUrl}/v1/api/app/contracts/active/",
            headers: {"Authorization": "Token " + authToken.getToken});
        activeContracts(json.decode(res.body), res.statusCode);
        res = await http.get("${baseUrl.getUrl}/v1/api/app/contracts/past/",
            headers: {"Authorization": "Token " + authToken.getToken});
        pastContracts(json.decode(res.body), res.statusCode);
      }
      yield MyworkLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is getReportList) {
      yield MyworkLoading();
      var response = await http.get(
          "${baseUrl.getUrl}/v1/api/app/contracts/report/list/",
          headers: {"Authorization": "Token " + authToken.getToken});
      listOfInfo.setReportList = json.decode(response.body)['feedback'];
      yield MyworkLoaded();
    }

    if (event is reportContract) {
      yield MyworkLoading();
      var response = await http.post(
          "${baseUrl.getUrl}/v1/api/app/contracts/${event.contractID}/report/",
          headers: {
            "Authorization": "Token " + authToken.getToken
          },
          body: {
            "reason": event.reportHint,
            "description": event.reportDetails,
          });
      if (response.statusCode == 200) {
        var res = await http.get(
            "${baseUrl.getUrl}/v1/api/app/contracts/active/",
            headers: {"Authorization": "Token " + authToken.getToken});
        activeContracts(json.decode(res.body), res.statusCode);
        res = await http.get("${baseUrl.getUrl}/v1/api/app/contracts/past/",
            headers: {"Authorization": "Token " + authToken.getToken});
        pastContracts(json.decode(res.body), res.statusCode);
      }
      yield MyworkLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is sendInvoice) {
      yield MyworkLoading();
      var response = await http.post(
          "${baseUrl.getUrl}/v1/api/app/contracts/${event.contractID}/invoice/",
          headers: {"Authorization": "Token " + authToken.getToken},
          body: {"hours": event.hour, "minutes": event.minute});
      yield MyworkLoadedwithResponse(response, response.statusCode);
    }

    if (event is postClientReview) {
      yield MyworkLoading();
      var response = await http.post(
          "${baseUrl.getUrl}/v1/api/app/contracts/review/${event.clientID}/",
          headers: {
            "Authorization": "Token " + authToken.getToken
          },
          body: {
            "contract_id": "${event.contractID}",
            "rating": "${event.rating}",
            "text": event.details,
          });
      yield MyworkLoadedwithResponse(response, response.statusCode);
    }
  }
}
