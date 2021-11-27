import 'package:random_string/random_string.dart';

class TextUtils {
  static String getOrderId() {
    return 'ORDER' + randomNumeric(8);
  }

  static String getRefId() {
    return 'REFID' + randomNumeric(8);
  }

  static String getTransId() {
    return 'TRANSID' + randomNumeric(8);
  }
}