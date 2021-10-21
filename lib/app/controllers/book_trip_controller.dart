import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/station.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'dart:async';

class BookTripController extends GetxController {
  final _tripProvider = Get.find<TripProvider>();

  Rx<Station> departureStation = Station.empty().obs;
  Rx<Station> destinationStation = Station.empty().obs;
  RxList<Station> listDepartureStation = <Station>[].obs;
  RxList<Station> listDestinationStation = <Station>[].obs;
  Rx<RoadInfo> roadInfo = RoadInfo().obs;

  Future<void> updateDepartureStation(value) async {
    departureStation.value = value;

    if (departureStation.value.stationId! >= 0) {
      await getListRelatedStation();
    } else {
      listDestinationStation.value =
          List.filled(1, Station.boilerplate(CustomStrings.kChooseTo.tr));
      destinationStation.value = listDestinationStation[0];
    }
  }

  void updateDestinationStation(value) {
    destinationStation.value = value;
  }

  Future<void> initial() async {
    getListStation();
    listDestinationStation.value =
        List.filled(1, Station.boilerplate(CustomStrings.kChooseTo.tr));
    destinationStation.value = listDestinationStation[0];
  }

  Future<void> getListStation() async {
    listDepartureStation.value = ((await StationProvider()
            .getStations(page: 1, limit: 20))['data'] as List)
        .map((e) => Station.fromJson(e))
        .toList();

    listDepartureStation.insert(
        0, Station.boilerplate(CustomStrings.kChooseFrom.tr));

    departureStation.value = listDepartureStation[0];
  }

  Future<void> getListRelatedStation() async {
    listDestinationStation.value = (await StationProvider()
            .getListRelatedStation(
                departureId: departureStation.value.stationId ?? -1) as List)
        .map((e) => Station.fromJson(e))
        .toList();

    listDestinationStation.insert(
        0, Station.boilerplate(CustomStrings.kChooseTo.tr));

    destinationStation.value = listDestinationStation[0];
  }

  Future<dynamic> createKeNowTrip() async {
    DateTime _currentTime = DateTime.now();
    Map<String, dynamic> data = <String, dynamic>{
      'KeerId': Biike.userId.value,
      'DepartureId': departureStation.value.stationId,
      'DestinationId': destinationStation.value.stationId,
      'BookTime': DateTime(_currentTime.year, _currentTime.month,
              _currentTime.day, _currentTime.hour, _currentTime.minute + 15)
          .toIso8601String(),
      'IsScheduled': false
    };
    return await _tripProvider.createKeNowTrip(data);
  }
}
