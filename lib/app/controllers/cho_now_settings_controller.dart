import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/bike_availability.dart';
import 'package:bikes_user/app/data/models/station.dart';
import 'package:bikes_user/app/data/providers/bike_availability_provider.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:bikes_user/app/ui/android/pages/cho_now_settings/widgets/pick_up_station_card.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChoNowSettingsController extends GetxController {
  final _stationProvider = Get.find<StationProvider>();
  final _bikeAvailabilityProvider = Get.find<BikeAvailabilityProvider>();
  final PagingController<int, PickUpStationCard> pagingController =
      PagingController(firstPageKey: 0);

  // Rx<String> stationName = CustomStrings.kChooseStation.obs;
  Rx<Station> selectedStation = Station.empty().obs;
  Rxn<TimeOfDay> fromTime = Rxn<TimeOfDay>();
  Rx<String> fromTimeString = CustomStrings.kChooseTime.tr.obs;
  Rxn<TimeOfDay> toTime = Rxn<TimeOfDay>();
  Rx<String> toTimeString = CustomStrings.kChooseTime.tr.obs;
  // RxList pickUpStations = [].obs;
  Rx<bool> isRideNowStationsLoading = true.obs;
  // Rx<String> selectedStationName = CustomStrings.kChooseStation.tr.obs;

  List<Station> stations = [];
  List<PickUpStationCard> rideNowStations = [];
  List<PickUpStationCard> _tempRideNowStations = [];
  Map<String, dynamic> pagination = {};
  int _currentPage = 1;
  int _limit = 10;

  @override
  onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  @override
  dispose() {
    pagingController.dispose();
    super.dispose();
  }

  /// Lazy loading when view upcoming trips or load stations.
  ///
  /// Author: TamNTT
  Future<void> _fetchPage(int pageKey) async {
    try {
      await getRideNowStations();
      isRideNowStationsLoading.value = true;

      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;
      final bool isLastPage =
          pagination['totalRecord'] - previouslyFetchedItemsCount <= _limit;

      if (isLastPage) {
        pagingController.appendLastPage(_tempRideNowStations);
        _currentPage = 1;
      } else {
        _currentPage += 1;
        int nextPageKey = pageKey;
        nextPageKey += _tempRideNowStations.length;
        pagingController.appendPage(_tempRideNowStations, nextPageKey);
      }
      isRideNowStationsLoading.value = false;
    } catch (error) {
      isRideNowStationsLoading.value = false;
      pagingController.error = error;
      CommonFunctions.catchExceptionError(error);
    }
  }

  /// Load Ride Now stations from API.
  ///
  /// Author: TamNTT
  Future<List<PickUpStationCard>> getRideNowStations() async {
    isRideNowStationsLoading.value = true;
    _tempRideNowStations.clear();

    Map<String, dynamic> response = await _bikeAvailabilityProvider
        .getRideNowStations(page: _currentPage, limit: _limit);
    pagination = response['_meta'];

    for (var station in response['data']) {
      BikeAvailability bikeAvailability = BikeAvailability.fromJson(station);

      PickUpStationCard pickUpStationCard = PickUpStationCard(
          id: bikeAvailability.bikeAvailabilityId!,
          stationId: bikeAvailability.stationId!,
          stationName: bikeAvailability.stationName!,
          timeRange: bikeAvailability.fromTime!.hour.toString() +
              ':' +
              bikeAvailability.fromTime!.minute.toString() +
              ' - ' +
              bikeAvailability.toTime!.hour.toString() +
              bikeAvailability.toTime!.minute.toString());

      _tempRideNowStations.add(pickUpStationCard);
      rideNowStations.add(pickUpStationCard);
    }
    isRideNowStationsLoading.value = false;

    return _tempRideNowStations.cast();
  }

  /// Load stations from database
  ///
  /// Author: TamNTT
  Future<void> loadStations() async {
    stations.clear();

    Map<String, dynamic> response =
        await _stationProvider.getStations(page: _currentPage, limit: _limit);

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
  Future<bool> addPickUpStation() async {
    Biike.logger.d(addPickUpStation);
    Biike.logger.d(selectedStation.value.stationId);
    Biike.logger.d(fromTime.value!.hour);
    Biike.logger.d(toTime.value!.hour);
    // await _bikeAvailabilityProvider.addRideNowStation(body: {
    //   'stationId': selectedStation.value.stationId,
    //   'fromTime':
    //       DateTime(2021, 1, 1, fromTime.value!.hour, fromTime.value!.minute)
    //           .toIso8601String(),
    //   'toTime': DateTime(2021, 1, 1, toTime.value!.hour, toTime.value!.minute)
    //       .toIso8601String()
    // });
    // Get.back();
    // update();
    return true;
  }

  /// Delete the selected pick up station
  ///
  /// Author: TamNTT
  Future<bool> deletePickUpStation({required int index}) async {
    PickUpStationCard station = rideNowStations.elementAt(index);
    if (await _bikeAvailabilityProvider.deleteRideNowStation(id: station.id)) {
      return true;
    } else {
      return false;
    }
  }

  /// Edit the selected pick up station data
  ///
  /// Author: TamNTT
  Future<bool> editPickUpStation(
      {required int index,
      required String name,
      required String timeRange}) async {
    PickUpStationCard station = rideNowStations.elementAt(index);
    if (await _bikeAvailabilityProvider
        .editRideNowStation(id: station.id, body: {
      'stationId': selectedStation.value.stationId,
      'fromTime':
          DateTime(2021, 1, 1, fromTime.value!.hour, fromTime.value!.minute)
              .toIso8601String(),
      'toTime': DateTime(2021, 1, 1, toTime.value!.hour, toTime.value!.minute)
          .toIso8601String()
    })) {
      return true;
    } else {
      return false;
    }
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
  bool checkIfStationWereAdded() {
    Biike.logger.d(checkIfStationWereAdded);
    for (PickUpStationCard station in rideNowStations) {
      String stationFromTimeString = station.timeRange.split(' - ')[0];
      String stationFromTimeHour = stationFromTimeString.split(':')[0];
      String stationFromTimeMinute = stationFromTimeString.split(':')[1];
      String stationToTimeString = station.timeRange.split(' - ')[1];
      String stationToTimeHour = stationToTimeString.split(':')[0];
      String stationToTimeMinute = stationToTimeString.split(':')[1];
      TimeOfDay stationFromTime = TimeOfDay(
          hour: int.tryParse(stationFromTimeHour)!,
          minute: int.tryParse(stationFromTimeMinute)!);
      TimeOfDay stationToTime = TimeOfDay(
          hour: int.tryParse(stationToTimeHour)!,
          minute: int.tryParse(stationToTimeMinute)!);
      Biike.logger.d(stationFromTime.hour);
      Biike.logger.d(stationFromTime.minute);
      Biike.logger.d(stationToTime.hour);
      Biike.logger.d(stationToTime.minute);
      if ((station.stationName == selectedStation.value.name) &&
          ((fromTime.value!.hour * 60 + fromTime.value!.minute >=
                  stationFromTime.hour * 60 + stationFromTime.minute) &&
              (toTime.value!.hour * 60 + toTime.value!.minute <=
                  stationToTime.hour * 60 + stationToTime.minute))) {
        return true;
      }
    }
    return false;
  }
}
