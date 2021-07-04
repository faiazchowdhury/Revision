import 'package:revised_quickassist/bloc/Bloc/services_bloc.dart';

class serviceCategoryList {
  static var _response;
  static int _code;
  static List<String> _servicesList;

  static get getResponse => _response;
  static get getCode => _code;
  static get getServicesList => _servicesList;

  serviceCategoryList(res, code, List<String> services) {
    _response = res;
    _code = code;
    _servicesList = services;
  }
}
