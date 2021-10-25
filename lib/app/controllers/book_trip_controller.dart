import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/enums/date_enum.dart';
import 'package:bikes_user/app/data/models/station.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'dart:async';

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

  // Rx<RoadInfo> roadInfo = RoadInfo().obs;

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
  void updateDestinationStation(value) {
    destinationStation.value = value;
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

  /// Select specific time to book a scheduled trip
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
    Map<String, dynamic> data = <String, dynamic>{
      'KeerId': Biike.userId.value,
      'DepartureId': this.departureStation.value.stationId,
      'DestinationId': this.destinationStation.value.stationId,
      'BookTime': DateTime(currentTime.year, currentTime.month, currentTime.day,
              currentTime.hour, currentTime.minute + 15)
          .toIso8601String(),
      'IsScheduled': false
    };
    return await _tripProvider.createKeNowTrip(data);
  }

  Future<dynamic> createScheduledTrip() async {
    DateTime date = DateTime(
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

    Map<String, dynamic> data = <String, dynamic> {
      'KeerId': Biike.userId.value,
      'DepartureId': this.departureStation.value.stationId,
      'DestinationId': this.destinationStation.value.stationId,
      'BookTime' : _getListOfDates(startDate, endDate)
          .map((e) => e.toIso8601String())
          .toList(),
      'IsScheduled' : true
    };

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
    DateTime result = DateTime(date.year, date.month, date.day + (iteration),
      date.hour, date.minute);

    if (_dateList.contains(Date.values[result.weekday])) {
      return list.add(result);
    }
  }

  /// Check if fill all fields
  ///
  /// Author: UyenNLP
  String _checkValidBeforeScheduleTrip(DateTime date) {
    if (!isDateSelected.value || !isTimeSelected.value)
      return CustomErrorsString.kNotFillAllFields.tr;

    // Is repeated
    if (isRepeated.value) {
      if (_dateList.isEmpty)
        return CustomErrorsString.kNotFillAllFields.tr;
    } else {
      if (date.isBefore(DateTime.now()))
        return CustomErrorsString.kNotAfterNow.tr;
    }

    return '';
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
    listDestinationStation.value = (await StationProvider()
            .getListRelatedStation(
                departureId: departureStation.value.stationId ?? -1) as List)
        .map((e) => Station.fromJson(e))
        .toList();

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

    return startDate.add(Duration(days: duration > 1 // not on weekend
        ? duration + DateTime.daysPerWeek  // add 1 more week
        : duration + 2*DateTime.daysPerWeek)); // else add 2 more weeks
  }
}
