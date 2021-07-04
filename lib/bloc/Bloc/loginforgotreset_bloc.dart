import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:revised_quickassist/Model/authToken.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';

part '../Event/loginforgotreset_event.dart';
part '../State/loginforgotreset_state.dart';

class LoginforgotresetBloc
    extends Bloc<LoginforgotresetEvent, LoginforgotresetState> {
  LoginforgotresetBloc() : super(LoginforgotresetInitial());

  @override
  Stream<LoginforgotresetState> mapEventToState(
    LoginforgotresetEvent event,
  ) async* {
    if (event is checkLogin) {
      yield LoginforgotresetLoading();
      var response = await http.post(
        '${baseUrl.getUrl}/v1/api/app/account/login/',
        body: {"email": event.email, "password": event.pass},
      );
      if (response.statusCode == 200) {
        authToken.setToken(json.decode(response.body)['token'].toString());
        final storage = new FlutterSecureStorage();
        await storage.write(
            key: 'token',
            value: json.decode(response.body)['token'].toString());
      }
      yield LoginforgotresetLoadedwithResponse(
          json.decode(response.body), response.statusCode);
    }

    if (event is forgotPassword) {
      yield LoginforgotresetLoading();
      Uri url =
          Uri.parse("${baseUrl.getUrl}/v1/api/app/account/password/forgot/");
      var response = await http.post(
        url,
        body: {
          "email": event.email,
        },
      );
      yield LoginforgotresetLoadedwithResponse(response, response.statusCode);
    }

    if (event is resetPassword) {
      yield LoginforgotresetLoading();
      Uri url =
          Uri.parse('${baseUrl.getUrl}/v1/api/app/account/password/reset/');
      var response = await http.post(
        url,
        body: {
          "email": event.email,
          "code": event.code,
          "password": event.password,
        },
      );
      yield LoginforgotresetLoadedwithResponse(response, response.statusCode);
    }
  }
}
