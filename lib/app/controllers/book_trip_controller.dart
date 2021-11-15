import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_objects/custom_location.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/enums/date_enum.dart';
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

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<bool> isDateSelected = false.obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  Rx<bool> isTimeSelected = false.obs;
  Rx<bool> isRepeated = false.obs;

  Rx<String> roadDistance = ''.obs;
  Rx<String> roadDuration = ''.obs;

  RxList<LatLng> polypoints = <LatLng>[].obs;

  /// Thứ
  List<Date> _dateList = [];

  /// Initialize BookTrip screen
  ///
  /// Author: UyenNLP
  Future<void> init() async {
    _getListStation();
    listDestinationStation.value =
        List.filled(1, Station.boilerplate(CustomStrings.kChooseTo.tr));
    destinationStation.value = listDestinationStation[0];
  }

  /// Change data of the departure station
  ///
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
  void addToDateList(Date date) {
    if (!_dateList.contains(date)) {
      _dateList.add(date);
    }
  }

  /// Remove from a repeated date list
  ///
  /// Author: UyenNLP
  void removeFromDateList(Date date) {
    if (_dateList.contains(date)) {
      _dateList.remove(date);
    }
  }

  /// Select specific date to book a scheduled trip
  ///
  /// Author: TamNTT
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: CustomStrings.kChooseDate.tr,
      cancelText: CustomStrings.kCancel.tr,
    );
    if (picked != null && picked != selectedDate.value) {
      isDateSelected.value = true;
      selectedDate.value = picked;
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

  /// Set date from selected tag
  ///
  /// Author: UyenNLP
  void setTimeFromTag(String date) {
    isTimeSelected.value = true;
    selectedTime.value = CommonFunctions.stringToTimeOfDay(date);
  }

  /// Change value to repeat that scheduled trip or not
  ///
  /// Author: TamNTT
  void changeRepeat() {
    isRepeated.value = !isRepeated.value;
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

    return await _tripProvider.createKeNowTrip(data);
  }

  /// Ké-er book a scheduled trip
  ///
  /// Author: UyenNLP
  Future<dynamic> createScheduledTrip() async {
    DateTime startDate = DateTime(
        selectedDate.value.year,
        selectedDate.value.month,
        selectedDate.value.day,
        selectedTime.value.hour,
        selectedTime.value.minute);

    String check = _checkValidBeforeScheduleTrip(startDate);
    if (check != '') {
      return check;
    }

    DateTime endDate = _getEndDate(startDate);

    var data = _getJsonData(
        isScheduled: true,
        bookTime: _getListOfDates(startDate, endDate)
            .map((e) => e.toIso8601String())
            .toList());

    return await _tripProvider.createScheduledTrip(data);
  }

  /// Get list of dates with the same name of date as listDate contains
  ///
  /// Author: UyenNLP
  List<DateTime> _getListOfDates(DateTime start, DateTime end) {
    if (!isRepeated.value) {
      return [start];
    }

    List<DateTime> listOfDays = [];
    final numberOfDate = end.difference(start).inDays + 1;
    List.generate(numberOfDate, (i) => _filterDate(listOfDays, start, i));

    return listOfDays;
  }

  /// Add a date with the same name of date as listDate contains
  ///
  /// Author: UyenNLP
  dynamic _filterDate(List list, DateTime date, int iteration) {
    DateTime result = DateTime(
        date.year, date.month, date.day + (iteration), date.hour, date.minute);

    if (_dateList.contains(Date.values[result.weekday])) {
      return list.add(result);
    }
  }

  /// Check if valid
  ///
  /// Author: UyenNLP
  String _checkValidBeforeScheduleTrip(DateTime date) {
    if (!isDateSelected.value || !isTimeSelected.value)
      return CustomErrorsString.kNotFillAllFields.tr;

    if (!_isAvailable(date))
      return CustomErrorsString.kNotAvailableTimeRange.tr;

    // Is repeated
    if (isRepeated.value) {
      if (_dateList.isEmpty) return CustomErrorsString.kNotFillAllFields.tr;
    } else {
      if (date.isBefore(DateTime.now()))
        return CustomErrorsString.kNotAfterNow.tr;
    }

    return '';
  }

  /// Check if valid
  ///
  /// Author: UyenNLP
  String _checkValidBeforeKeNow(DateTime date) {
    if (!_isAvailable(date)) {
      return CustomErrorsString.kNotAvailableTimeRange.tr;
    }

    if (departureStation.value.stationId == -1 ||
        destinationStation.value.stationId == -1) {
      return CustomErrorsString.kNotChooseStation.tr;
    }

    return '';
  }

  /// If selected time in the available time range
  ///
  /// Author: UyenNLP
  bool _isAvailable(DateTime date) {
    TimeOfDay startTime = TimeOfDay(hour: 6, minute: 00);
    TimeOfDay endTime = TimeOfDay(hour: 21, minute: 00);

    return ((date.hour > startTime.hour) ||
            (date.hour == startTime.hour && date.minute >= startTime.minute)) &&
        ((date.hour < endTime.hour) ||
            (date.hour == endTime.hour && date.minute <= endTime.minute));
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

  /// Get end date when selected repeated
  ///
  /// Author: UyenNLP
  _getEndDate(DateTime startDate) {
    // get duration from the startDate to end of that week
    var duration = DateTime.daysPerWeek - startDate.weekday;

    return startDate.add(Duration(
        days: duration > 1 // not on weekend
            ? duration + DateTime.daysPerWeek // add 1 more week
            : duration + 2 * DateTime.daysPerWeek)); // else add 2 more weeks
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
}
