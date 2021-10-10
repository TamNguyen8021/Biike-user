import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/starting_station.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/home_provider.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Manage states of [HomePage]
class HomeController extends GetxController {
  final _homeProvider = Get.put(HomeProvider());

  Rx<bool> isAppBarVisible = true.obs;
  Rx<DateTime> searchDate = DateTime.now().obs;
  Rx<TimeOfDay> searchTime = TimeOfDay.now().obs;
  Rx<String> searchDateString = CustomStrings.kChooseDate.tr.obs;
  Rx<String> searchTimeString = CustomStrings.kChooseTime.tr.obs;

  List upcomingTrips = [];
  Map<int?, String> stations = {};

  /// Show/hide appbar depends on [isVisible]
  ///
  /// Author: TamNTT
  void setAppBarVisible(isVisible) {
    isAppBarVisible.value = isVisible;
  }

  /// Load upcoming trips from API.
  ///
  /// Author: TamNTT
  Future<void> getUpcomingTrips({required BuildContext context}) async {
    upcomingTrips.clear();
    List response = await _homeProvider.getUpcomingTrips(
        userId: await Biike.localAppData.getUserId());
    // print('response: ' + response.toString());
    // print('response length: ' + response.length.toString());
    for (int i = 0; i < response.length; i++) {
      User user = User.fromJson(response[i]);
      // print(user.toJson());
      Trip trip = Trip.fromJson(response[i]);
      // print(trip.toJson());
      StartingStation startingStation = StartingStation.fromJson(response[i]);
      // print(startingStation.toJson());
      DestinationStation destinationStation =
          DestinationStation.fromJson(response[i]);
      // print(destinationStation.toJson());
      String date = DateTime.parse(trip.timeBook).day.toString() +
          ' Th ' +
          DateTime.parse(trip.timeBook).month.toString();

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
          name: user.fullName,
          phoneNo: user.phoneNumber,
          time: DateFormat('HH:mm').format(DateTime.parse(trip.timeBook)),
          date: date,
          year: DateTime.parse(trip.timeBook).year,
          sourceStation: startingStation.startingPointName,
          destinationStation: destinationStation.destinationName);

      upcomingTrips.add(upcomingTripCard);
      // print(upcomingTrips.length);
    }
  }

  /// Load stations from API.
  ///
  /// Author: TamNTT
  Future<void> getStations({required int page}) async {
    List response = await _homeProvider.getStations();
    for (var station in response) {
      StartingStation startingStation = StartingStation.fromJson(station);
      stations.putIfAbsent(
          startingStation.stationId, () => startingStation.startingPointName);
    }
  }
}
