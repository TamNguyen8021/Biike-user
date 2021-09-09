import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTripController extends GetxController {
  Rx<DateTime> dateSelected = DateTime.now().obs;
  Rx<bool> isDateSelected = false.obs;
  Rx<TimeOfDay> timeSelected = TimeOfDay.now().obs;
  Rx<bool> isTimeSelected = false.obs;

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