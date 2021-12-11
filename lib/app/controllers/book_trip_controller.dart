import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_objects/custom_location.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/station.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookTripController extends GetxController {
  final _tripProvider = Get.find<TripProvider>();

  Rx<Station> departureStation = Station.empty().obs;
  Rx<Station> destinationStation = Station.empty().obs;
  RxList<Station> listDepartureStation = <Station>[].obs;
  RxList<Station> listDestinationStation = <Station>[].obs;

  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  Rx<bool> isTimeSelected = false.obs;

  Rx<String> roadDistance = ''.obs;
  Rx<String> roadDuration = ''.obs;

  RxList<LatLng> polypoints = <LatLng>[].obs;

  List<DateTime> dateList = [];
  List<DateTime> _selectedDateList = [];

  /// Initialize BookTrip screen
  ///
  /// Author: UyenNLP
  Future<void> init() async {
    _getListStation();
    listDestinationStation.value =
        List.filled(1, Station.boilerplate(CustomStrings.kChooseTo.tr));
    destinationStation.value = listDestinationStation[0];

    DateTime today = DateTime.now();
    dateList = List.generate(DateTime.daysPerWeek,
        (index) => DateTime(today.year, today.month, today.day + index));
  }

  /// Change data of the departure station
  ///p
  /// Author: UyenNLP
  Future<void> updateDepartureStation(value) async {
    departureStation.value = value;
    polypoints.value = [];
    roadDistance.value = '';
    roadDuration.value = '';

    if (departureStation.value.stationId! >= 0) {
      await _getListRelatedStation();
    } else {
      listDestinationStation.value =
          List.filled(1, Station.boilerplate(CustomStrings.kChooseTo.tr));
      destinationStation.value = listDestinationStation[0];
    }
  }

  /// Change data of the destination station
  ///
  /// Author: UyenNLP
  void updateDestinationStation(destinationValue) async {
    polypoints.clear();

    CustomLocation departure =
        CustomLocation(coordinate: departureStation.value.coordinate);
    CustomLocation destination =
        CustomLocation(coordinate: destinationValue.coordinate);
    Map<String, dynamic> response = await _tripProvider.getDurationAndDistance(
        startLat: departure.latitude,
        startLng: departure.longitude,
        endLat: destination.latitude,
        endLng: destination.longitude);

    await CommonFunctions().getRoutePoints(
        polypoints: polypoints.toList(),
        startLat: departure.latitude,
        startLng: departure.longitude,
        endLat: destination.latitude,
        endLng: destination.longitude);

    destinationStation.value = destinationValue;
    roadDistance.value = response['rows'][0]['elements'][0]['distance']['text'];
    roadDuration.value = response['rows'][0]['elements'][0]['duration']['text'];
  }

  /// Add to a repeated date list
  ///
  /// Author: UyenNLP
  void addToDateList(DateTime date) {
    if (!_selectedDateList.contains(date)) {
      _selectedDateList.add(date);
    }
  }

  /// Remove from a repeated date list
  ///
  /// Author: UyenNLP
  void removeFromDateList(DateTime date) {
    if (_selectedDateList.contains(date)) {
      _selectedDateList.remove(date);
    }
  }

  /// Select specific date to book a scheduled trip
  ///
  /// Author: TamNTT
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      helpText: CustomStrings.kChooseTime.tr,
      cancelText: CustomStrings.kCancel.tr,
    );
    if (picked != null) {
      isTimeSelected.value = true;
      selectedTime.value = picked;
    }
  }

  /// Ké-er book a ké-now trip
  ///
  /// Author: UyenNLP
  Future<dynamic> createKeNowTrip() async {
    DateTime currentTime = DateTime.now();
    DateTime bookTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, currentTime.hour, currentTime.minute + 15);

    String check = _checkValidBeforeKeNow(bookTime);
    if (check != '') {
      return check;
    }

    var data =
        _getJsonData(isScheduled: false, bookTime: bookTime.toIso8601String());

    var result = await _tripProvider.createSingleTrip(data);

    return _returnMsg(result);
  }

  /// Ké-er book a scheduled trip
  ///
  /// Author: UyenNLP
  Future<dynamic> createScheduledTrip() async {
    String check = _checkValidBeforeScheduleTrip();
    if (check != '') {
      return check;
    }

    var data = _getJsonData(
        isScheduled: true,
        bookTime: _selectedDateList.length > 1
            ? _getListOfDates().map((e) => e.toIso8601String()).toList()
            : DateTime(
                    _selectedDateList.first.year,
                    _selectedDateList.first.month,
                    _selectedDateList.first.day,
                    selectedTime.value.hour,
                    selectedTime.value.minute)
                .toIso8601String());

    var result = _selectedDateList.length > 1
        ? await _tripProvider.createMultipleTrip(data)
        : await _tripProvider.createSingleTrip(data);

    return _returnMsg(result);
  }

  /// Get list of dates with the same name of date as listDate contains
  ///
  /// Author: UyenNLP
  List<DateTime> _getListOfDates() {
    var now = DateTime.now();
    return _selectedDateList
        .map((date) => DateTime(date.year, date.month, date.day,
            selectedTime.value.hour, selectedTime.value.minute))
        .where((date) => date.isAfter(now))
        .toList();
  }

  /// Check if valid
  ///
  /// Author: UyenNLP
  String _checkValidBeforeScheduleTrip() {
    if (!isTimeSelected.value || _selectedDateList.length == 0)
      return CustomErrorsString.kNotFillAllFields.tr;

    if (!_isAvailable()) return CustomErrorsString.kNotAvailableTimeRange.tr;

    if (_selectedDateList.length == 1) {
      DateTime date = DateTime(
          _selectedDateList.first.year,
          _selectedDateList.first.month,
          _selectedDateList.first.day,
          selectedTime.value.hour,
          selectedTime.value.minute);
      if (date.isBefore(DateTime.now()))
        return CustomErrorsString.kNotAfterNow.tr;
    }
    return '';
  }

  /// Check if valid when book ke-now
  ///
  /// Author: UyenNLP
  String _checkValidBeforeKeNow(DateTime date) {
    if (!_isAvailable()) return CustomErrorsString.kNotAvailableTimeRange.tr;

    if (departureStation.value.stationId == -1 ||
        destinationStation.value.stationId == -1) {
      return CustomErrorsString.kNotChooseStation.tr;
    }

    return '';
  }

  /// If selected time in the available time range
  ///
  /// Author: UyenNLP
  bool _isAvailable() {
    TimeOfDay startTime = TimeOfDay(hour: 6, minute: 00);
    TimeOfDay endTime = TimeOfDay(hour: 21, minute: 00);

    return ((selectedTime.value.hour > startTime.hour) ||
            (selectedTime.value.hour == startTime.hour &&
                selectedTime.value.minute >= startTime.minute)) &&
        ((selectedTime.value.hour < endTime.hour) ||
            (selectedTime.value.hour == endTime.hour &&
                selectedTime.value.minute <= endTime.minute));
  }

  /// Get a full list of station from db
  ///
  /// Author: UyenNLP
  Future<void> _getListStation() async {
    listDepartureStation.value = ((await StationProvider()
            .getStations(page: 1, limit: 20))['data'] as List)
        .map((e) => Station.fromJson(e))
        .toList();

    listDepartureStation.insert(
        0, Station.boilerplate(CustomStrings.kChooseFrom.tr));

    departureStation.value = listDepartureStation[0];
  }

  /// Get a list of destination station by departure station
  ///
  /// Author: UyenNLP
  Future<void> _getListRelatedStation() async {
    var response = await StationProvider().getListRelatedStation(
        page: 1,
        limit: 10,
        departureId: departureStation.value.stationId ?? -1);
    listDestinationStation.value =
        (response['data'] as List).map((e) => Station.fromJson(e)).toList();

    listDestinationStation.insert(
        0, Station.boilerplate(CustomStrings.kChooseTo.tr));

    destinationStation.value = listDestinationStation[0];
  }

  /// Get data to attach to body of api
  ///
  /// Author: UyenNLP
  Map<String, dynamic> _getJsonData(
      {required bool isScheduled, required dynamic bookTime}) {
    return <String, dynamic>{
      'KeerId': Biike.userId.value,
      'DepartureId': this.departureStation.value.stationId,
      'DestinationId': this.destinationStation.value.stationId,
      'BookTime': bookTime,
      'IsScheduled': isScheduled
    };
  }

  dynamic _returnMsg(result) {
    if (result is bool) return result;

    if (result.contains('is already existed'))
      return CustomErrorsString.kTripTimeExist.tr;

    if (result.contains('exceeding max number of trip'))
      return CustomErrorsString.kExceedMaxTrips.tr;

    if (result.contains('is less than'))
      return CustomErrorsString.kBookAnHourPrior.tr;

    return result;
  }
}
