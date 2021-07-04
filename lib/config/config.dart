import 'package:revised_quickassist/Model/baseUrl.dart';

class config {
  static void seturl() {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    if (isProduction == false) {
      baseUrl.setUrl("");
    } else {
      baseUrl.setUrl("");
    }
  }
}
