import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/departure_station.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/home_provider.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Manage states of [HomePage]
class HomeController extends GetxController {
  final _homeProvider = Get.put(HomeProvider());
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);

  Rx<bool> isAppBarVisible = true.obs;
  Rx<DateTime> searchDate = DateTime.now().obs;
  Rx<TimeOfDay> searchTime = TimeOfDay.now().obs;
  Rx<String> searchDateString = CustomStrings.kChooseDate.tr.obs;
  Rx<String> searchTimeString = CustomStrings.kChooseTime.tr.obs;

  RxList upcomingTrips = [].obs;
  Map<int?, String> stations = {};
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
      if (Biike.role.value == Role.keer) {
        await getUpcomingTrips();
        print(upcomingTrips.length);
      } else {
        await getStations();
      }
      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;
      final bool isLastPage =
          pagination['totalRecord'] - previouslyFetchedItemsCount <= _limit;
      if (isLastPage) {
        if (Biike.role.value == Role.keer) {
          pagingController.appendLastPage(upcomingTrips.toList());
        } else {
          pagingController.appendLastPage(stations.values.toList());
        }
        _currentPage = 1;
      } else {
        _currentPage += 1;
        int nextPageKey = pageKey;
        if (Biike.role.value == Role.keer) {
          nextPageKey += upcomingTrips.length;
          pagingController.appendPage(upcomingTrips.toList(), nextPageKey);
        } else {
          nextPageKey += stations.length;
          pagingController.appendPage(stations.values.toList(), nextPageKey);
        }
      }
    } catch (error) {
      pagingController.error = error;
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
    Map<String, dynamic> response = await _homeProvider.getUpcomingTrips(
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
    print(upcomingTrips.length);
    return upcomingTrips.cast();
  }

  /// Load stations from API.
  ///
  /// Author: TamNTT
  Future<Map> getStations() async {
    stations.clear();
    Map<String, dynamic> response =
        await _homeProvider.getStations(page: _currentPage, limit: _limit);
    pagination = response['_meta'];

    for (var station in response['data']) {
      DepartureStation startingStation = DepartureStation.fromJson(station);
      stations.putIfAbsent(
          startingStation.stationId, () => startingStation.departureName);
    }
    return stations;
  }

  dynamic showStationsDialog({required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: stations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(stations.values.elementAt(index));
                  }),
            ),
          );
        });
  }
}
