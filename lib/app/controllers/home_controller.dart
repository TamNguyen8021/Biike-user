import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/starting_station.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/home_provider.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Manage states of [HomePage]
class HomeController extends GetxController {
  final _homeProvider = Get.put(HomeProvider());

  Rx<bool> isAppBarVisible = true.obs;
  List upcomingTrips = [];

  /// Show/hide appbar depends on [isVisible]
  ///
  /// Author: TamNTT
  void setAppBarVisible(isVisible) {
    isAppBarVisible.value = isVisible;
  }

  /// Load upcoming trips from API based on [userId] and [role].
  ///
  /// Author: TamNTT
  Future<void> getUpcomingTrips(
      {required BuildContext context, required userId, required role}) async {
    upcomingTrips.clear();
    List response =
        await _homeProvider.getUpcomingTrips(userId: userId, role: role);
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
      String date = trip.timeBook.day.toString() +
          ' Th ' +
          trip.timeBook.month.toString();

      Color backgroundColor = CustomColors.kLightGray;
      Color foregroundColor = CustomColors.kDarkGray;
      Color iconColor = CustomColors.kBlue;

      if (i == 0) {
        backgroundColor = CustomColors.kBlue;
        foregroundColor = iconColor = Colors.white;
      }

      UpcomingTripCard upcomingTripCard = UpcomingTripCard(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          iconColor: iconColor,
          avatarUrl: user.avatar,
          name: user.userFullname,
          phoneNo: user.userPhoneNumber,
          time: DateFormat('HH:mm').format(trip.timeBook),
          date: date,
          year: trip.timeBook.year,
          sourceStation: startingStation.startingPointName,
          destinationStation: destinationStation.destinationName);

      upcomingTrips.add(upcomingTripCard);
      print(upcomingTrips.length);
    }
  }
}
