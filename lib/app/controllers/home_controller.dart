import 'dart:convert';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/starting_station.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manage states of [HomePage]
class HomeController extends GetxController {
  Rx<bool> isAppBarVisible = true.obs;
  RxList<dynamic> upcomingTrips = [].obs;

  /// Show/hide appbar depends on [isVisible]
  ///
  /// Author: TamNTT
  void setAppBarVisible(isVisible) {
    isAppBarVisible.value = isVisible;
  }

  /// Load upcoming trips from json file.
  ///
  /// Author: TamNTT
  Future<void> getUpcomingTrips({required BuildContext context}) async {
    upcomingTrips.clear();
    String response = await DefaultAssetBundle.of(context)
        .loadString('assets/files/upcoming_trips.json');
    List<dynamic> data = jsonDecode(response);
    // print('data: ' + data.toString());
    // print('data length: ' + data.length.toString());
    for (int i = 0; i < data.length; i++) {
      User user = User.fromJson(data[i]);
      // print(user.toJson());
      Trip trip = Trip.fromJson(data[i]);
      // print(trip.toJson());
      StartingStation startingStation = StartingStation.fromJson(data[i]);
      // print(startingStation.toJson());
      DestinationStation destinationStation =
          DestinationStation.fromJson(data[i]);
      // print(destinationStation.toJson());
      String date = trip.timeBook.day.toString() +
          ' Th ' +
          trip.timeBook.month.toString();
      String time = '';
      if (trip.timeBook.hour < 10) {
        time += '0';
      }
      time = time +
          trip.timeBook.hour.toString() +
          ':' +
          trip.timeBook.minute.toString();
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
          time: time,
          date: date,
          year: trip.timeBook.year,
          sourceStation: startingStation.startingPointName,
          destinationStation: destinationStation.destinationName);

      upcomingTrips.add(upcomingTripCard);
      // print(upcomingTrips.length);
    }
  }
}
