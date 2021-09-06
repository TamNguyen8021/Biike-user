import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookScheduleTripController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<bool> isDateSelected = false.obs;
  Rx<DateTime> repeatedDate = DateTime.now().obs;
  Rx<bool> isRepeatedDateSelected = false.obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  Rx<bool> isTimeSelected = false.obs;
  Rx<bool> isRepeated = false.obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: CustomStrings.kChooseDate,
      cancelText: CustomStrings.kCancel,
    );
    if (picked != null && picked != selectedDate.value) {
      isDateSelected.value = true;
      selectedDate.value = picked;
    }
  }

  Future<void> selectRepeatingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: repeatedDate.value.isBefore(selectedDate.value)
          ? selectedDate.value
          : repeatedDate.value,
      firstDate: selectedDate.value,
      lastDate: DateTime(2101),
      helpText: CustomStrings.kChooseDate,
      cancelText: CustomStrings.kCancel,
    );
    if (picked != null && picked != repeatedDate.value) {
      isRepeatedDateSelected.value = true;
      repeatedDate.value = picked;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      helpText: CustomStrings.kChooseTime,
      cancelText: CustomStrings.kCancel,
    );
    if (picked != null) {
      isTimeSelected.value = true;
      selectedTime.value = picked;
    }
  }

  void changeRepeat() {
    isRepeated.value = !isRepeated.value;
  }
}
