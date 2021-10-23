import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:get/get.dart';

enum Date { dummy, monday, tuesday, wednesday, thursday, friday, saturday, sunday }

extension DateExtension on Date {
  String getDateText(int date) {
    switch (date) {
      case 1:
        return CustomStrings.kMonday.tr;
      case 2:
        return CustomStrings.kTuesday.tr;
      case 3:
        return CustomStrings.kWednesday.tr;
      case 4:
        return CustomStrings.kThursday.tr;
      case 5:
        return CustomStrings.kFriday.tr;
      case 6:
        return CustomStrings.kSaturday.tr;
      case 7:
        return CustomStrings.kSunday.tr;
      default:
        return '';
    }
  }
}
