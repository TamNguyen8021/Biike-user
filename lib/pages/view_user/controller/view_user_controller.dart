import 'dart:convert';

import 'package:bikes_user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewUserController extends GetxController {
  User user = User.empty();

  /// Get user info from json file.
  ///
  /// Author: TamNTT
  Future<void> getUserInfo({required BuildContext context}) async {
    String response = await DefaultAssetBundle.of(context)
        .loadString('assets/files/user.json');
    Map<String, dynamic> data = jsonDecode(response);
    // print('data: ' + data.toString());
    // print('data length: ' + data.length.toString());
    user = User.fromJson(data);
    print(user.toJson());
  }
}
