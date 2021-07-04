class activeContracts {
  static var _response;
  static int _code;

  static get getResponse => _response;
  static get getCode => _code;

  activeContracts(res, code) {
    _response = res;
    _code = code;
  }
}
