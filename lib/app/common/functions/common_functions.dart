import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

/// Contains functions which are called multiple times in app
class CommonFunctions {
  /// Use device default phone app to make a call to [phoneNo].
  ///
  /// Author: TamNTT
  makingPhoneCall({required String phoneNo}) async {
    String url = 'tel:$phoneNo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Use device default message app to send a message to [phoneNo].
  ///
  /// Author: TamNTT
  makingSms({required String phoneNo}) async {
    String url = 'sms:$phoneNo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Avoid force shutdown when user press backbutton with the message: [errorMessage].
  ///
  /// Author: UyenNLP
  Future<bool> onBackPressed({String? errorMessage}) {
    errorMessage == null
      ? Get.defaultDialog(
        title: 'Confirm',
        middleText: 'Do you want to exit the app?',
        middleTextStyle: TextStyle(color: Colors.black),
        textCancel: CustomStrings.kCancel.tr,
        textConfirm: 'Yes',
        onConfirm: () => SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop')) //exit the app

    : Get.snackbar(CustomErrorsString.kError.tr,
        errorMessage.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);

    return Future.value(false);
  }
}
