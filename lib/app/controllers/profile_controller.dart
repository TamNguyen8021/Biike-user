import 'dart:convert';

import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/profile_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  final _profileProvider = Get.put(ProfileProvider());

  User user = User.empty();
  Rx<DateTime> birthDate = DateTime.now().obs;
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
  Future<void> getProfile({required BuildContext context}) async {
    var data = await _profileProvider.getProfile(userId: Biike.userId);
    // print('data: ' + data.toString());
    // print('data length: ' + data.length.toString());
    user = User.fromJson(data);
    // print(user.toJson());
    if (user.birthDate.isNotEmpty) {
      birthDate.value = DateTime.parse(user.birthDate);
    }
    tempName = user.userFullname;
    tempGender = user.gender;
    tempBirthDate = user.birthDate;
  }

  bool isSaveButtonDisable(
      {required String newName,
      required int newGender,
      required String newBirthDate}) {
    return (tempName == newName) &&
        (tempGender == newGender) &&
        (tempBirthDate == newBirthDate);
  }

  Future<void> editProfile(
      {required BuildContext context, required User user}) async {
    Map<String, dynamic> newUserProfile = {};
    newUserProfile.putIfAbsent('userFullname', () => user.userFullname);
    newUserProfile.putIfAbsent('gender', () => user.gender);
    newUserProfile.putIfAbsent('birthDate',
        () => DateFormat('yyyy-MM-dd').format(DateTime.parse(user.birthDate)));
    // print(newUserProfile);
    Future<String> message = _profileProvider.editProfile(
        userId: Biike.userId, body: jsonEncode(newUserProfile));
    CommonFunctions()
        .showSuccessDialog(context: context, message: await message);
  }
}
