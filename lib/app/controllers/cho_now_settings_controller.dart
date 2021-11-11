import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/station.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:bikes_user/app/ui/android/pages/cho_now_settings/widgets/pick_up_station_card.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoNowSettingsController extends GetxController {
  final _stationProvider = Get.find<StationProvider>();

  Rx<bool> isChoNowOn = false.obs;
  // Rx<String> stationName = CustomStrings.kChooseStation.obs;
  Rx<Station> selectedStation = Station.empty().obs;
  Rxn<TimeOfDay> fromTime = Rxn<TimeOfDay>();
  Rx<String> fromTimeString = CustomStrings.kChooseTime.tr.obs;
  Rxn<TimeOfDay> toTime = Rxn<TimeOfDay>();
  Rx<String> toTimeString = CustomStrings.kChooseTime.tr.obs;
  RxList pickUpStations = [].obs;
  // Rx<String> selectedStationName = CustomStrings.kChooseStation.tr.obs;

  List<Station> stations = [];
  int _page = 1;
  int _limit = 10;

  /// Load stations from database
  ///
  /// Author: TamNTT
  Future<void> loadStations() async {
    stations.clear();

    Map<String, dynamic> response =
        await _stationProvider.getStations(page: _page, limit: _limit);

    for (var stationObject in response['data']) {
      Station station = Station.fromJson(stationObject);
      stations.add(station);
    }

    if (stations.isNotEmpty) {
      selectedStation.value = stations.first;
    }
  }

  /// Add a pick up station for Cho Now when user presses 'Add' button
  ///
  /// Author: TamNTT
  Future<void> addPickUpStation({required BuildContext context}) async {
    if (_checkIfStationWereAdded(
        name: selectedStation.value.name,
        from: fromTime.value!,
        to: toTime.value!)) {
      CommonFunctions().showErrorDialog(
          context: context,
          message: CustomErrorsString.kSameStationWereAdded.tr);
    } else {
      Rx<String> timeRange = (MaterialLocalizations.of(context).formatTimeOfDay(
                  fromTime.value!,
                  alwaysUse24HourFormat: true) +
              ' - ' +
              MaterialLocalizations.of(context)
                  .formatTimeOfDay(toTime.value!, alwaysUse24HourFormat: true))
          .obs;
      Rx<String> stationName = selectedStation.value.name.obs;
      pickUpStations.add(
          PickUpStationCard(stationName: stationName, timeRange: timeRange));
      Get.back();
    }
  }

  /// Delete the selected pick up station
  ///
  /// Author: TamNTT
  Future<void> deletePickUpStation({required int index}) async {
    pickUpStations.removeAt(index);
    Get.back();
  }

  /// Edit the selected pick up station data
  ///
  /// Author: TamNTT
  Future<void> editPickUpStation(
      {required int index,
      required String name,
      required String timeRange}) async {
    PickUpStationCard station = pickUpStations.elementAt(index);
    station.stationName.value = name;
    station.timeRange.value = timeRange;
    Get.back();
  }

  /// Validate if all fields are not null
  ///
  /// Author: TamNTT
  bool checkIfAllFieldsHaveData() {
    bool isValid = true;

    if (selectedStation.value.stationId == -1) {
      isValid = false;
    }

    if (fromTime.value == null) {
      isValid = false;
    }

    if (toTime.value == null) {
      isValid = false;
    }

    return isValid;
  }

  /// Author: TamNTT
  bool _checkIfStationWereAdded(
      {required String name, required TimeOfDay from, required TimeOfDay to}) {
    for (PickUpStationCard station in pickUpStations) {
      String stationFromTimeString = station.timeRange.value.split(' - ')[0];
      String stationFromTimeHour = stationFromTimeString.split(':')[0];
      String stationFromTimeMinute = stationFromTimeString.split(':')[1];
      String stationToTimeString = station.timeRange.value.split(' - ')[1];
      String stationToTimeHour = stationToTimeString.split(':')[0];
      String stationToTimeMinute = stationToTimeString.split(':')[1];
      TimeOfDay stationFromTime = TimeOfDay(
          hour: int.tryParse(stationFromTimeHour)!,
          minute: int.tryParse(stationFromTimeMinute)!);
      TimeOfDay stationToTime = TimeOfDay(
          hour: int.tryParse(stationToTimeHour)!,
          minute: int.tryParse(stationToTimeMinute)!);
      if ((station.stationName.value == name) &&
          (from.hour * 60 + from.minute >=
              stationFromTime.hour * 60 + stationFromTime.minute) &&
          (to.hour * 60 + to.minute <=
              stationToTime.hour * 60 + stationToTime.minute)) {
        return true;
      }
    }
    return false;
  }
}
