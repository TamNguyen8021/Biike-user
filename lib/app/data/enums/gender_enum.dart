import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:get/get.dart';

enum Gender { male, female, other }

extension GenderExtension on Gender {
  String getGenderText(int gender) {
    switch (gender) {
      case 1:
        return CustomStrings.kMale.tr;
      case 2:
        return CustomStrings.kFemale.tr;
      case 3:
        return CustomStrings.kOthers.tr;
      default:
        return '';
    }
  }

  Gender getGenderEnum(int gender) {
    switch (gender) {
      case 1:
        return Gender.male;
      case 2:
        return Gender.female;
      default:
        return Gender.other;
    }
  }
}
