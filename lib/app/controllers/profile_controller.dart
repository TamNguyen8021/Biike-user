import 'dart:convert';

import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  final _userProvider = Get.find<UserProvider>();

  User user = User.empty();
  Rxn<DateTime> birthDate = Rxn<DateTime>();
  String tempName = '';
  int tempGender = -1;
  String tempBirthDate = '';

  /// Change user's gender with [newGender].
  ///
  /// Author: TamNTT
  void changeGender(newGender) {
    user.gender = newGender;
  }

  /// Change user's name with [name].
  ///
  /// Author: TamNTT
  void changeName(String name) {
    user.userFullname = name;
  }

  /// Gets profile based on [userId] and shows it on [context].
  ///
  /// Author: TamNTT
  Future<void> getProfile() async {
    var data = await _userProvider.getProfile(userId: Biike.userId.value);
    user = User.fromJson(data);

    birthDate.value = DateTime.tryParse(user.birthDate!);

    tempName = user.userFullname;
    tempGender = user.gender;
    tempBirthDate = user.birthDate!;
  }

  bool isSaveButtonDisable(
      {required String newName,
      required int newGender,
      required String newBirthDate}) {
    return (tempName == newName) &&
        (tempGender == newGender) &&
        (tempBirthDate == newBirthDate);
  }

  Future<bool> editProfile(
      {required BuildContext context, required User user}) async {
    Map<String, dynamic> newUserProfile = {};

    newUserProfile.putIfAbsent('userFullname', () => user.userFullname);
    newUserProfile.putIfAbsent('gender', () => user.gender);
    newUserProfile.putIfAbsent(
        'birthDate',
        () => DateFormat('yyyy-MM-dd')
            .format(DateTime.tryParse(user.birthDate!)!));

    bool isSuccess = await _userProvider.editProfile(
        userId: Biike.userId.value, body: jsonEncode(newUserProfile));
    if (isSuccess) {
      CommonFunctions().showSuccessDialog(
          context: context, message: CustomStrings.kEditProfileSuccess.tr);
      return true;
    } else {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kEditProfileFailed.tr);
      return false;
    }
  }
}
