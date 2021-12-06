import 'dart:convert';

import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/enums/image_type_enum.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/image_provider.dart'
    as imageProvider;
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  final _userProvider = Get.find<UserProvider>();
  final _imageProvider = Get.find<imageProvider.ImageProvider>();

  User user = User.empty();
  Rxn<DateTime> birthDate = Rxn<DateTime>();
  Rx<String> avatarUrl = ''.obs;
  String tempName = '';
  int tempGender = -1;
  String? tempBirthDate;
  String avatarName = '';

  @override
  void onInit() async {
    await getIt<TokenService>().refreshToken();
    super.onInit();
  }

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

    if (user.birthDate != null) {
      birthDate.value = DateTime.tryParse(user.birthDate!);
    }

    tempName = user.userFullname;
    tempGender = user.gender;
    tempBirthDate = user.birthDate;
    avatarUrl.value = user.avatar;
    update();
  }

  bool isSaveButtonDisable(
      {required String newName,
      required int newGender,
      required String? newBirthDate}) {
    return (tempName == newName) &&
        (tempGender == newGender) &&
        (tempBirthDate == newBirthDate) &&
        avatarUrl.value.contains('http');
  }

  Future<bool> editProfile(
      {required BuildContext context, required User user}) async {
    Map<String, dynamic> newUserProfile = {};

    newUserProfile.putIfAbsent('userFullname', () => user.userFullname);
    newUserProfile.putIfAbsent('gender', () => user.gender);

    if (user.birthDate != null) {
      newUserProfile.putIfAbsent(
          'birthDate',
          () => DateFormat('yyyy-MM-dd')
              .format(DateTime.tryParse(user.birthDate!)!));
    }

    if (!avatarUrl.value.contains('http')) {
      ImageType imageType = ImageType.user;
      String newAvatarUrl = await _imageProvider.postImage(
          imageType: imageType.getImageTypeInt(imageType),
          imageName: avatarName,
          imagePath: avatarUrl.value);

      newUserProfile.putIfAbsent('avatar', () => newAvatarUrl);
    }

    bool isSuccess = await _userProvider.editProfile(
        userId: Biike.userId.value, body: jsonEncode(newUserProfile));
    if (isSuccess) {
      update();
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
