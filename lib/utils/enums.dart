import 'package:bikes_user/utils/custom_strings.dart';

enum Gender { male, female, other }

extension GenderExtension on Gender {
  String getGenderText(int gender) {
    switch (gender) {
      case 1:
        return CustomStrings.kMale;
      case 2:
        return CustomStrings.kFemale;
      case 3:
        return CustomStrings.kOthers;
      default:
        return '';
    }
  }
}

enum Role { none, keer, biker }
enum TripStatus { none, finding, waiting, started, finished, canceled }
