import 'dart:io';

class serviceProviderInfo {
  static String _name, _img;
  static int _approvalCode;
  static List<String> _tScheduleType = [];
  static List<String> _tScheduleTime = [];
  static List<String> _nScheduleType = [];
  static List<String> _nScheduleTime = [];
  static List<String> _nScheduleDate = [];
  static bool _noWork = false;
  static bool _visible = false,
      _checkAvailability = true,
      _checkService = true,
      _checkLocation = true;
  static String get name => _name;
  static int get approvalCode => _approvalCode;
  static String get img => _img;
  static bool get noWork => _noWork;
  static bool get visible => _visible;
  static List<String> get tScheduleType => _tScheduleType;
  static List<String> get tScheduleTime => _tScheduleTime;
  static List<String> get nScheduleType => _nScheduleType;
  static List<String> get nScheduleTime => _nScheduleTime;
  static List<String> get nScheduleDate => _nScheduleDate;
  static bool get availability => _checkAvailability;
  static bool get service => _checkService;
  static bool get location => _checkLocation;

  static set setName(val) => _name = val;
  static set setApprovalCode(val) => _approvalCode = val;
  static set setImg(val) => _img = val;
  static set setTScheduleType(val) => _tScheduleType = val;
  static set setTScheduleTime(val) => _tScheduleTime = val;
  static set setNScheduleType(val) => _nScheduleType = val;
  static set setNScheduleTime(val) => _nScheduleTime = val;
  static set setNScheduleDate(val) => _nScheduleDate = val;
  static set setNoWork(val) => _noWork = val;
  static set setVisible(val) => _visible = val;
  static set setCheckAvailability(val) => _checkAvailability = val;
  static set setCheckService(val) => _checkService = val;
  static set setCheckLocation(val) => _checkLocation = val;
}
