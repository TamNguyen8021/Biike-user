import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/station.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:get/get.dart';

class BookTripController extends GetxController {
  Rx<Station> departureStation = Station.empty().obs;
  Rx<Station> destinationStation = Station.empty().obs;
  RxList<Station> listDepartureStation = <Station>[].obs;
  RxList<Station> listDestinationStation = <Station>[].obs;

  void updateDepartureStation(value) {
    departureStation.value = value;

    if (departureStation.value.stationId! >= 0) {
      getListRelatedStation();
    } else {
      listDestinationStation.value = List.filled(1, Station.boilerplate(CustomStrings.kChooseTo.tr));
      destinationStation.value = listDestinationStation[0];
    }
  }

  void updateDestinationStation(value) {
    destinationStation.value = value;
  }

  Future<void> initial() async {
    getListStation();
    listDestinationStation.value = List.filled(1, Station.boilerplate(CustomStrings.kChooseTo.tr));
    destinationStation.value = listDestinationStation[0];
  }

  Future<void> getListStation() async {
    listDepartureStation.value = (await StationProvider()
        .getListStation() as List)
        .map((e) => Station.fromJson(e))
        .toList();

    listDepartureStation.insert(0, Station.boilerplate(CustomStrings.kChooseFrom.tr));

    departureStation.value = listDepartureStation[0];
  }

  Future<void> getListRelatedStation() async {
    listDestinationStation.value = (await StationProvider()
        .getListRelatedStation(departureId: departureStation.value.stationId ?? -1) as List)
        .map((e) => Station.fromJson(e))
        .toList();

    listDestinationStation.insert(0, Station.boilerplate(CustomStrings.kChooseTo.tr));

    destinationStation.value = listDestinationStation[0];
  }
}
