import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
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
      required Rx<DateTime?> selectedDate,
      required bool isBirthDatePicker}) async {
    DateTime _currentTime = DateTime.now();
    DateTime _firstDate = DateTime(_currentTime.year - 90);
    DateTime _lastDate = DateTime(_currentTime.year - 18, 12, 31);

    if (!isBirthDatePicker) {
      _firstDate = _currentTime;
      _lastDate = DateTime(_currentTime.year + 1, DateTime.december, 31);
    }

    if (selectedDate.value == null) {
      selectedDate.value = _currentTime;
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime(_currentTime.year - 18),
      firstDate: _firstDate,
      lastDate: _lastDate,
      helpText: CustomStrings.kChooseDate.tr,
      cancelText: CustomStrings.kCancel.tr,
      fieldLabelText: CustomStrings.kBirthDate.tr,
    );
    return pickedDate!;
  }

  /// Show a time picker on [context].
  ///
  /// Author: TamNTT
  Future<TimeOfDay> selectTime(
      {required BuildContext context,
      required Rx<TimeOfDay?> selectedTime}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value ?? TimeOfDay.now(),
      helpText: CustomStrings.kChooseTime.tr,
      cancelText: CustomStrings.kCancel.tr,
    );

    return pickedTime!;
  }

  /// Display a dialog on [context] for success message.
  ///
  /// Author: TamNTT
  void showSuccessDialog(
      {required BuildContext context, required String message}) async {
    await showDialog(
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
                    textAlign: TextAlign.center,
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
  void showErrorDialog(
      {required BuildContext context, required String message}) async {
    await showDialog(
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
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Display a dialog on [context] for info message.
  ///
  /// Author: TamNTT
  void showInfoDialog(
      {required BuildContext context, required String message}) async {
    await showDialog(
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
                      'assets/images/info.svg',
                      height: 50,
                    ),
                  ),
                  Text(
                    message.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Display a confirm dialog on [context].
  ///
  /// Author: TamNTT
  void showConfirmDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required Function() onPressedFunc}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 30.0),
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        CustomTextButton(
                          hasBorder: false,
                          backgroundColor: CustomColors.kBlue,
                          foregroundColor: Colors.white,
                          text: CustomStrings.kSure.tr,
                          onPressedFunc: onPressedFunc,
                        ),
                        CustomTextButton(
                            hasBorder: false,
                            backgroundColor: CustomColors.kLightGray,
                            foregroundColor: CustomColors.kDarkGray,
                            text: CustomStrings.kBtnExit.tr,
                            onPressedFunc: () {
                              Get.back();
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Get object id from returned [url].
  ///
  /// Author: UyenNLP
  static int getIdFromUrl({required String url}) {
    int indexOfForwardSlash = url.lastIndexOf('/');
    int indexOfQuestionMark = url.indexOf('?');

    return indexOfQuestionMark != -1 // not found
        ? int.tryParse(
                url.substring(indexOfForwardSlash + 1, indexOfQuestionMark)) ??
            -1
        : int.tryParse(url.substring(indexOfForwardSlash + 1)) ?? -1;
  }

  Future<void> openMap(
      {required String keyword,
      required double? latitude,
      required double? longitude,
      required BuildContext context}) async {
    String googleUrl =
        'https://www.google.com/maps/search/$keyword/@$latitude,$longitude';

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError.tr);
      FlutterLogs.logError(
          'Biiké', 'CommonFunctions - openMap()', 'Could not open map');
      Biike.logger.e('Could not open map');
    }
  }

  /// Get polypoints to draw route on map
  ///
  /// Author: TamNTT
  Future<void> getRoutePoints(
      {required List<LatLng> polypoints,
      required double startLat,
      required double startLng,
      required double endLat,
      required double endLng}) async {
    polypoints.clear();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        UrlStrings.googleMapApiKey,
        PointLatLng(startLat, startLng),
        PointLatLng(endLat, endLng));

    for (PointLatLng point in result.points) {
      polypoints.add(LatLng(point.latitude, point.longitude));
    }
  }

  /// Convert string to timeOfDate
  ///
  /// Author: UyenNLP
  static TimeOfDay stringToTimeOfDay(String time) {
    final format = DateFormat.Hm(); //"16:00"
    return TimeOfDay.fromDateTime(format.parse(time));
  }
}
