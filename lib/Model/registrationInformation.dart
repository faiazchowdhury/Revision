class registrationInformation {
  static String _name;
  static String _email;
  static String _pass;
  static String _city;
  static String _services;
  static String _checkbox;
  static String _country;
  static String _phoneNumber;
  static String _vehicle;
  static String _ssn;
  static String _state;
  static String _appSuits;
  static String _livingCity;
  static String _dob;
  static String _zip;
  static String _streetNN;
  static String _paymentMethodId;

  static get getEmail {
    return _email;
  }

  static get getPass {
    return _pass;
  }

  static get getName {
    return _name;
  }

  static get getServices {
    return _services;
  }

  static get getCheckBox {
    return _checkbox;
  }

  static get getCity {
    return _city;
  }

  static get getCountry {
    return _country;
  }

  static get getPhoneNumber {
    return _phoneNumber;
  }

  static get getVehicle {
    return _vehicle;
  }

  static get getSsn {
    return _ssn;
  }

  static get getAppsuits {
    return _appSuits;
  }

  static get getState {
    return _state;
  }

  static get getLivingCity {
    return _livingCity;
  }

  static get getDOB {
    return _dob;
  }

  static get getZip {
    return _zip;
  }

  static get getStreetnn {
    return _streetNN;
  }

  static get getPaymentMethodId {
    return _paymentMethodId;
  }

  static void setEmailPassNameFlag(
      String email, String pass, String name, String flag) {
    _name = name;
    _pass = pass;
    _email = email;
    _checkbox = flag;
  }

  static void setCountryPhoneNumber(String country, String number) {
    _country = country;
    _phoneNumber = number;
  }

  static void setCity(String city) {
    _city = city;
  }

  static void setVehicle(String vehicle) {
    _vehicle = vehicle;
  }

  static void setServices(String services) {
    _services = services;
  }

  static void setInfo(String ssn, String state, String appSuits,
      String living_city, String zip, String streetNN) {
    _ssn = ssn;
    _state = state;
    _appSuits = appSuits;
    _livingCity = living_city;
    _zip = zip;
    _streetNN = streetNN;
  }

  static void setDOB(String dob) {
    _dob = dob;
  }

  static void setPaymentMethodId(String pmid) {
    _paymentMethodId = pmid;
  }

  static void delete() {
    _name = null;
    _pass = null;
    _email = null;
  }
}
