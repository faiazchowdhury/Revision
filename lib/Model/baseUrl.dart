class baseUrl {
  static String _baseUrl;
  static String _picUrl;
  static String get getUrl {
    return _baseUrl;
  }

  static String get getpicUrl {
    return _picUrl;
  }

  static void setUrl(url) {
    _baseUrl = url;
    _picUrl = url;
  }
}
