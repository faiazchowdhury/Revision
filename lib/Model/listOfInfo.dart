class listOfInfo {
  static List<String> _vehicleType = [
    'No vehicle',
    'Sedan',
    'Truck',
    'Pick-Up'
  ];
  static List<String> _amountOfTimeHours = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  static List<String> _amountOfTimeMinutes = ['00', '15', '30', '45'];

  static List _cancelList = [];
  static List _reportList = [];

  static get vehicleType => _vehicleType;
  static get cancelList => _cancelList;
  static get reportList => _reportList;
  static get amountOfTimeHours => _amountOfTimeHours;
  static get amountOfTimeMinutes => _amountOfTimeMinutes;

  static set setCancelList(list) => _cancelList = list;
  static set setReportList(list) => _reportList = list;
}
