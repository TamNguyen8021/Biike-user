import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/departure_station.dart';
import 'package:bikes_user/app/data/models/station.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Manage states of [HomePage]
class HomeController extends GetxController {
  final _tripProvider = Get.find<TripProvider>();
  final _stationProvider = Get.find<StationProvider>();
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);

  Rx<bool> isAppBarVisible = true.obs;
  Rxn<DateTime> searchDate = Rxn<DateTime>();
  Rxn<TimeOfDay> searchTime = Rxn<TimeOfDay>();
  Rx<String> searchDateString = CustomStrings.kChooseDate.tr.obs;
  Rx<String> searchTimeString = CustomStrings.kChooseTime.tr.obs;
  Rx<Station> departureStation = Station.empty().obs;
  Rx<Station> destinationStation = Station.empty().obs;
  Rx<String> departureStationName = CustomStrings.kSelectSourceStation.tr.obs;
  Rx<String> destinationStationName =
      CustomStrings.kSelectDestinationStation.tr.obs;
  RxList upcomingTrips = [].obs;
  RxList upcomingTripsForBiker = [].obs;
  Map<int?, String> stations = {};
  Map<String, dynamic> pagination = {};
  bool hasSearchedTrips = false;
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
      await getUpcomingTrips();

      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;
      final bool isLastPage =
          pagination['totalRecord'] - previouslyFetchedItemsCount <= _limit;
      if (isLastPage) {
        // if (Biike.role.value == Role.keer) {
        pagingController.appendLastPage(upcomingTrips.toList());
        // } else {
        //   pagingController.appendLastPage(stations.values.toList());
        // }
        _currentPage = 1;
      } else {
        _currentPage += 1;
        int nextPageKey = pageKey;
        // if (Biike.role.value == Role.keer) {
        nextPageKey += upcomingTrips.length;
        pagingController.appendPage(upcomingTrips.toList(), nextPageKey);
        // } else {
        //   nextPageKey += stations.length;
        //   pagingController.appendPage(stations.values.toList(), nextPageKey);
        // }
      }
    } catch (error) {
      pagingController.error = error;
      Biike.logger.e('HomeController - _fetchPage()', error);
      FlutterLogs.logErrorTrace(
          'Biike', 'HomeController - _fetchPage()', error.toString(), Error());
    }
  }

  /// Show/hide appbar depends on [isVisible]
  ///
  /// Author: TamNTT
  void setAppBarVisible(isVisible) {
    isAppBarVisible.value = isVisible;
  }

  /// Load upcoming trips from API.
  ///
  /// Author: TamNTT
  Future<List<UpcomingTripCard>> getUpcomingTrips() async {
    upcomingTrips.clear();
    Map<String, dynamic> response = await _tripProvider.getUpcomingTrips(
        userId: Biike.userId.value, page: _currentPage, limit: _limit);
    pagination = response['_meta'];

    for (int i = 0; i < response['data'].length; i++) {
      User user = User.fromJson(response['data'][i]);
      Trip trip = Trip.fromJson(response['data'][i]);
      DepartureStation startingStation =
          DepartureStation.fromJson(response['data'][i]);
      DestinationStation destinationStation =
          DestinationStation.fromJson(response['data'][i]);

      Color backgroundColor = CustomColors.kLightGray;
      Color foregroundColor = CustomColors.kDarkGray;
      Color iconColor = CustomColors.kBlue;

      if (i == 0) {
        backgroundColor = CustomColors.kBlue;
        foregroundColor = iconColor = Colors.white;
      }

      UpcomingTripCard upcomingTripCard = UpcomingTripCard(
          tripId: trip.tripId,
          userId: user.userId,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          iconColor: iconColor,
          avatarUrl: user.avatar,
          name: user.userFullname,
          phoneNo: user.userPhoneNumber,
          bookTime: trip.bookTime,
          departureStation: startingStation.departureName,
          destinationStation: destinationStation.destinationName);

      upcomingTrips.add(upcomingTripCard);
    }
    return upcomingTrips.cast();
  }

  /// Load upcoming trips for biker from API.
  ///
  /// Author: TamNTT
  Future<List<UpcomingTripCard>> searchTrips(
      {DateTime? date,
      TimeOfDay? time,
      int? departureId,
      int? destinationId}) async {
    upcomingTripsForBiker.clear();
    hasSearchedTrips = true;

    Map<String, dynamic> response = await _tripProvider.searchTrips(
        page: _currentPage,
        limit: _limit,
        date: date,
        time: time,
        departureId: departureId,
        destinationId: destinationId);
    pagination = response['_meta'];

    for (var item in response['data']) {
      User user = User.fromJson(item);
      Trip trip = Trip.fromJson(item);
      DepartureStation startingStation = DepartureStation.fromJson(item);
      DestinationStation destinationStation = DestinationStation.fromJson(item);

      UpcomingTripCard upcomingTripCard = UpcomingTripCard(
          tripId: trip.tripId,
          userId: user.userId,
          avatarUrl: user.avatar,
          name: user.userFullname,
          phoneNo: user.userPhoneNumber,
          bookTime: trip.bookTime,
          departureStation: startingStation.departureName,
          destinationStation: destinationStation.destinationName);

      upcomingTripsForBiker.add(upcomingTripCard);
    }

    return upcomingTripsForBiker.cast();
  }

  /// Load stations from API.
  ///
  /// Author: TamNTT
  Future<Map> getStations() async {
    stations.clear();
    Map<String, dynamic> response;

    if (departureStation.value.stationId! > 0) {
      response = await _stationProvider.getListRelatedStation(
          page: _currentPage,
          limit: _limit,
          departureId: departureStation.value.stationId!);
    } else if (destinationStation.value.stationId! > 0) {
      response = await _stationProvider.getListRelatedStation(
          page: _currentPage,
          limit: _limit,
          departureId: destinationStation.value.stationId!);
    } else {
      response =
          await _stationProvider.getStations(page: _currentPage, limit: _limit);
    }
    pagination = response['_meta'];

    for (var station in response['data']) {
      Station departureStation = Station.fromJson(station);
      stations.putIfAbsent(
          departureStation.stationId, () => departureStation.name);
    }
    return stations;
  }

  /// Display a dialog which contains stations for user to choose.
  ///
  /// Author: TamNTT
  Future showStationsDialog(
      {required BuildContext context, required bool isDepartureStation}) async {
    Rx<int?> _tempStationId = (-1).obs;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
              future: getStations(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: stations.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(
                              () => RadioListTile<int?>(
                                title: Text(
                                  stations.values.elementAt(index),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                value: stations.keys.elementAt(index),
                                groupValue: _tempStationId.value,
                                onChanged: (int? stationId) {
                                  _tempStationId.value = stationId;
                                  if (isDepartureStation) {
                                    departureStation.value.stationId =
                                        _tempStationId.value;
                                    departureStationName.value =
                                        departureStation.value.name =
                                            stations.values.elementAt(index);
                                    Biike.logger
                                        .d(departureStation.value.stationId);
                                    Biike.logger.d(departureStation.value.name);
                                  } else {
                                    destinationStation.value.stationId =
                                        _tempStationId.value;
                                    destinationStationName.value =
                                        destinationStation.value.name =
                                            stations.values.elementAt(index);
                                    Biike.logger
                                        .d(destinationStation.value.stationId);
                                    Biike.logger
                                        .d(destinationStation.value.name);
                                  }
                                  Get.back();
                                },
                              ),
                            );
                          }),
                    ),
                  );
                } else {
                  return Loading();
                }
              });
        });
  }

  void swapStations() {
    // Swap name on UI
    String tempStationName = departureStationName.value;
    departureStationName.value = destinationStationName.value;
    destinationStationName.value = tempStationName;

    if (departureStationName.value ==
        CustomStrings.kSelectDestinationStation.tr) {
      departureStationName.value = CustomStrings.kSelectSourceStation.tr;
    }

    if (destinationStationName.value == CustomStrings.kSelectSourceStation.tr) {
      destinationStationName.value = CustomStrings.kSelectDestinationStation.tr;
    }

    // Swap id on back-end
    int tempStationId = departureStation.value.stationId!;
    departureStation.value.stationId = destinationStation.value.stationId;
    destinationStation.value.stationId = tempStationId;
  }
}
