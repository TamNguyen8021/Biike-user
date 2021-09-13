import 'package:bikes_user/utils/custom_strings.dart';

enum Gender { Male, Female, Other }

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

enum Role { None, Customer, Driver }
enum TripStatus { None, Finding, Waiting, Started, Finished, Canceled }
