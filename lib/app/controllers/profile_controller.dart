import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _profileProvider = Get.put(ProfileProvider());

  User user = User.empty();
  // Rx<String> fullname = ''.obs;
  // Rx<Gender> gender = Gender.male.obs;

  void changeGender(newGender) {
    user.gender = newGender;
  }

  /// Gets profile based on [userId] and shows it on [context].
  ///
  /// Author: TamNTT
  Future<void> getProfile(
      {required BuildContext context, required int userId}) async {
    var data = await _profileProvider.getProfile(userId: userId);
    // print('data: ' + data.toString());
    // print('data length: ' + data.length.toString());
    user = User.fromJson(data);
    // print(user.toJson());
  }
}
