import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/others/select_station_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTripController extends GetxController {
  Rx<DateTime> dateSelected = DateTime.now().obs;
  Rx<bool> isDateSelected = false.obs;
  Rx<TimeOfDay> timeSelected = TimeOfDay.now().obs;
  Rx<bool> isTimeSelected = false.obs;
  Rx<String> fromStation = CustomStrings.kSelectSourceStation.obs;
  Rx<String> toStation = CustomStrings.kSelectDestinationStation.obs;

  Future<void> selectFromStation(BuildContext context) async {
    this.fromStation.value = await showDialog(
      context: context,
      builder: (context) =>
          SelectStationDialog(
              title: CustomStrings.kSelectSourceStation,
              selectedStation: toStation.value
          ),
    );
  }

  Future<void> selectToStation(BuildContext context) async {
    this.toStation.value = await showDialog(
      context: context,
      builder: (context) =>
          SelectStationDialog(
              title: CustomStrings.kSelectDestinationStation,
              selectedStation: fromStation.value
          ),
    );
  }

  void switchFromAndToStation() {
    // Nếu chưa chọn cả 2 trạm thì không switch
    if (fromStation.value == CustomStrings.kSelectSourceStation &&
      toStation.value == CustomStrings.kSelectDestinationStation) {
      return;
    }

    // Nếu chỉ mới chọn 1 trong 2 trạm
    if (fromStation.value == CustomStrings.kSelectSourceStation) {
      fromStation.value = toStation.value;
      toStation.value = CustomStrings.kSelectDestinationStation;
      return;
    } else if (toStation.value == CustomStrings.kSelectDestinationStation) {
      toStation.value = fromStation.value;
      fromStation.value = CustomStrings.kSelectSourceStation;
      return;
    }

    // Nếu đã chọn cả 2
    var tmp = fromStation.value;
    fromStation.value = toStation.value;
    toStation.value = tmp;
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime now = new DateTime.now();
    DateTime today = new DateTime(now.year, now.month, now.day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateSelected.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: CustomStrings.kChooseDate,
      cancelText: CustomStrings.kCancel,
    );
    if (picked != null && picked != dateSelected.value) {
      dateSelected.value = picked;
      picked != today
        ? isDateSelected.value = true
        : isDateSelected.value = false;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeSelected.value,
      helpText: CustomStrings.kChooseTime,
      cancelText: CustomStrings.kCancel,
    );
    if (picked != null) {
      isTimeSelected.value = true;
      timeSelected.value = picked;
    }
  }
}