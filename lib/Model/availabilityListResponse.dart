class availabilityListResponse {
  static var _response;
  static int _code;
  static List<String> _startendDate;

  static get getResponse => _response;
  static get getCode => _code;
  static get getStartEndDate => _startendDate;

  availabilityListResponse(res, code, startendDate) {
    _response = res;
    _code = code;
    _startendDate = startendDate;
  }
}
