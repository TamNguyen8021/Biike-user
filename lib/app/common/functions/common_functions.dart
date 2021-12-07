import 'dart:math' as math;

import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_objects/custom_trace.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
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
import 'package:location/location.dart';
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
  makingSms({required List<String> phoneNo, required String body}) async {
    String recipients = '';
    for (int i = 0; i < phoneNo.length; i++) {
      recipients += phoneNo[i];
      if (i != phoneNo.length - 1) {
        recipients += ',';
      }
    }
    String url = 'sms:$recipients?body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Avoid force shutdown when user press backbutton with the message: [errorMessage].
  ///
  /// Author: UyenNLP
  Future<bool> onBackPressed(
      {required BuildContext context, String? errorMessage}) {
    errorMessage == null
        ? Get.defaultDialog(
        title: 'Confirm',
        middleText: 'Do you want to exit the app?',
        middleTextStyle: TextStyle(color: Colors.black),
        textCancel: CustomStrings.kCancel.tr,
        textConfirm: 'Yes',
        onConfirm: () =>
            SystemChannels.platform
                .invokeMethod<void>('SystemNavigator.pop')) //exit the app

        : CommonFunctions()
        .showErrorDialog(context: context, message: errorMessage);

    return Future.value(false);
  }

  /// Show a date picker on [context].
  ///
  /// Author: TamNTT
  Future<DateTime> selectDate({required BuildContext context,
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
  Future<TimeOfDay> selectTime({required BuildContext context,
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
  Future<void> showSuccessDialog(
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
                    style: Theme
                        .of(context)
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
  Future<void> showErrorDialog(
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
                    style: Theme
                        .of(context)
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
  Future<void> showInfoDialog(
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
                    style: Theme
                        .of(context)
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
  Future<void> showConfirmDialog({required BuildContext context,
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 30.0),
                    child: Text(
                      message,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomTextButton(
                            width: 100,
                            hasBorder: false,
                            backgroundColor: CustomColors.kLightGray,
                            foregroundColor: CustomColors.kDarkGray,
                            text: CustomStrings.kNo.tr,
                            onPressedFunc: () {
                              Get.back();
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CustomTextButton(
                          width: 100,
                          hasBorder: false,
                          backgroundColor: CustomColors.kBlue,
                          foregroundColor: Colors.white,
                          text: CustomStrings.kYes.tr,
                          onPressedFunc: onPressedFunc,
                        ),
                      ),
                    ],
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

  Future<void> openMap({required String keyword,
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
      logBiike(error: 'Could not open map');
    }
  }

  Future<void> openLink(
      {required String url, required BuildContext context}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError.tr);
      FlutterLogs.logError(
          'Biiké', 'CommonFunctions - openLink()', 'Could not open link');
      logBiike(error: 'Could not open link');
    }
  }

  /// Get polypoints to draw route on map
  ///
  /// Author: TamNTT
  Future<void> getRoutePoints({required List<LatLng> polypoints,
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

  /// Author: TamNTT
  Future<LocationData?> getCurrentLocation() async {
    final _location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    while (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    while (_permissionGranted == PermissionStatus.denied ||
        _permissionGranted == PermissionStatus.deniedForever) {
      _permissionGranted = await _location.requestPermission();
    }

    return _location.getLocation();
  }

  /// Convert string to timeOfDate
  ///
  /// Author: UyenNLP
  static TimeOfDay stringToTimeOfDay(String time) {
    final format = DateFormat.Hm(); //"16:00"
    return TimeOfDay.fromDateTime(format.parse(time));
  }

  /// Use haversine formula to calculate distance between 2 coordinates
  ///
  /// Author: TamNTT
  bool isArrivedAtPickUpPoint(
      {required double userLat,
      required double userLng,
      required double departureLat,
      required double departureLng}) {
    const r = 6371; // Radius of earth in kilometers. Use 3956 for miles
    double fi1 = userLat * math.pi / 180; // φ, λ in radians
    double fi2 = departureLat * math.pi / 180;
    double deltaFi = (departureLat - userLat) * math.pi / 180;
    double deltaLamda = (departureLng - userLng) * math.pi / 180;

    double a = math.sin(deltaFi / 2) * math.sin(deltaFi / 2) +
        math.cos(fi1) *
            math.cos(fi2) *
            math.sin(deltaLamda / 2) *
            math.sin(deltaLamda / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    double d = r * c; // in kilometres

    if (d < 0.5) {
      return true;
    }
    return false;
  }

  /// Log to Biike logger
  ///
  /// Author: UyenNLP
  static void logBiike({CustomTrace? info, required error}) {
    if (info == null) info = CustomTrace(StackTrace.current);

    Biike.logger.e('${info.callerFunctionName}()', error);
  }

  /// Log trace to Flutter logger
  ///
  /// Author: UyenNLP
  static void logErrorTraceFlutter({CustomTrace? info, required error}) {
    if (info == null) info = CustomTrace(StackTrace.current);

    FlutterLogs.logErrorTrace(
        'Biike', '${info.callerFunctionName}', error.toString(), Error());
  }

  /// Log exception error
  ///
  /// Author: UyenNLP
  static void catchExceptionError(error) {
    CustomTrace info = CustomTrace(StackTrace.current);

    logBiike(info: info, error: error);
    logErrorTraceFlutter(info: info, error: error);
  }

  static moveToNotiPageWhenHasNoti(String? title, String? body) {
    Get.snackbar(title ?? CustomStrings.kNotification.tr,
        body ?? CustomStrings.kNewNotification.tr,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        onTap: (_) => Get.toNamed(CommonRoutes.NOTIFICATION),
        isDismissible: true,
        duration: Duration(seconds: 3),
        backgroundColor: CustomColors.kBlue);
  }

  Widget lightBulbIcon(context, String title,
          {List<String> contents = const <String>[]}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
        child: IconButton(
          icon: Icon(Icons.lightbulb),
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text(title.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (var content in contents)
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 7.0),
                        child: Text(
                          content.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 14, color: CustomColors.kDarkGray),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CustomTextButton(
                          backgroundColor: CustomColors.kBlue,
                          foregroundColor: Colors.white,
                          text: CustomStrings.kGotIt.tr,
                          onPressedFunc: () =>
                            Get.back(),
                          hasBorder: false),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  /// Bind new instance if it hadn't been binded before
  /// to prevent repeatedly bind
  ///
  /// Author: UyenNLP
  static bind<S>(S dependency) {
    try {
      // has binded before
      Get.find<S>();

    } catch (e) {
      catchExceptionError(e);
      if (dependency is CommonProvider) {
        Get.put(dependency);
      } else if (dependency is GetxController) {
        Get.lazyPut<S>(() => dependency);
      }
    }
  }
}
