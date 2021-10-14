import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            onConfirm: () => SystemChannels.platform
                .invokeMethod<void>('SystemNavigator.pop')) //exit the app

        : Get.snackbar(CustomErrorsString.kError.tr, errorMessage.tr,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);

    return Future.value(false);
  }

  /// Show a date picker on [context].
  ///
  /// Author: TamNTT
  Future<DateTime> selectDate(
      {required BuildContext context,
      required Rx<DateTime> selectedDate,
      required bool isBirthDatePicker}) async {
    DateTime _currentTime = DateTime.now();
    DateTime _firstDate = DateTime(_currentTime.year - 90);
    DateTime _lastDate = DateTime(_currentTime.year - 18);

    if (!isBirthDatePicker) {
      _firstDate = _currentTime;
      _lastDate = DateTime(
          _currentTime.year, _currentTime.month, _currentTime.day + 15);
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: _firstDate,
      lastDate: _lastDate,
      helpText: CustomStrings.kChooseDate.tr,
      cancelText: CustomStrings.kCancel.tr,
      fieldLabelText: CustomStrings.kBirthDate,
    );
    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
    return selectedDate.value;
  }

  /// Show a time picker on [context].
  ///
  /// Author: TamNTT
  Future<String> selectTime(
      {required BuildContext context,
      required Rx<TimeOfDay> selectedTime}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      helpText: CustomStrings.kChooseTime.tr,
      cancelText: CustomStrings.kCancel.tr,
    );
    if (pickedTime != null) {
      selectedTime.value = pickedTime;
    }
    return MaterialLocalizations.of(context)
        .formatTimeOfDay(selectedTime.value, alwaysUse24HourFormat: true);
  }

  /// Display a dialog on [context] for success message.
  ///
  /// Author: TamNTT
  dynamic showSuccessDialog(
      {required BuildContext context, required String message}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SvgPicture.asset(
                      'assets/images/check.svg',
                      height: 50,
                    ),
                  ),
                  Text(
                    message.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Display a dialog on [context] for error message.
  ///
  /// Author: TamNTT
  dynamic showErrorDialog(
      {required BuildContext context, required String message}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SvgPicture.asset(
                      'assets/images/error.svg',
                      height: 50,
                    ),
                  ),
                  Text(
                    message.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static int getIdFromUrl({required String url}) {
    int indexOfForwardSlash = url.lastIndexOf('/');
    int indexOfQuestionMark = url.indexOf('?');

    return indexOfQuestionMark != -1 // not found
      ? int.parse(url.substring(indexOfForwardSlash + 1, indexOfQuestionMark))
      : int.parse(url.substring(indexOfForwardSlash + 1));
  }
}
