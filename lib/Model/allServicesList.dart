class allServicesList {
  static var _response;
  static int _code;

  static get getResponse => _response;
  static get getCode => _code;

  allServicesList(res, code) {
    _response = res;
    _code = code;
  }
}
