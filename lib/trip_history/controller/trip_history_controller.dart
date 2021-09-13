import 'package:bikes_user/models/destination_station.dart';
import 'package:bikes_user/models/starting_station.dart';
import 'package:bikes_user/models/trip.dart';
import 'package:bikes_user/models/user.dart';
import 'package:bikes_user/trip_history/view/trip_history_page.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/cards/history_trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

/// Manage states of [TripHistoryPage]
class TripHistoryController extends GetxController {
  // final tripHistoryProvider = Get.find<TripHistoryProvider>();

  RxList<dynamic> historyTrips = [].obs;
  Rx<Role> role = Role.Customer.obs;

  /// Load history trips from json file.
  ///
  /// Author: TamNTT
  Future<void> getHistoryTrips({required BuildContext context}) async {
    historyTrips.clear();
    String response = await DefaultAssetBundle.of(context)
        .loadString('assets/files/history_trip.json');
    var data = jsonDecode(response);
    var customerHistoryTrips = data[0];
    // print('customer: ' + customerHistoryTrips.toString());
    var driverHistoryTrips = data[1];
    // print('driver: ' + driverHistoryTrips.toString());
    var loadedData = customerHistoryTrips;
    if (role.value != Role.Customer) {
      loadedData = driverHistoryTrips;
    }
    // print('loaded data length: ' + loadedData.length.toString());
    for (var item in loadedData) {
      // print(item);
      User user = User.fromJson(item);
      // print(user.toJson());
      Trip trip = Trip.fromJson(item);
      // print(trip.toJson());
      StartingStation startingStation = StartingStation.fromJson(item);
      // print(startingStation.toJson());
      DestinationStation destinationStation = DestinationStation.fromJson(item);
      // print(destinationStation.toJson());
      TripStatus tripStatus;
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
      switch (trip.tripStatus) {
        case 1:
          tripStatus = TripStatus.Finding;
          break;
        case 2:
          tripStatus = TripStatus.Waiting;
          break;
        case 3:
          tripStatus = TripStatus.Started;
          break;
        case 4:
          tripStatus = TripStatus.Finished;
          break;
        case 5:
          tripStatus = TripStatus.Canceled;
          break;
        default:
          tripStatus = TripStatus.None;
          Get.defaultDialog(
              title: CustomStrings.kError,
              middleText: CustomStrings.kErrorMessage);
      }

      HistoryTripCard historyTripCard = HistoryTripCard(
          avatarUrl: user.avatar,
          name: user.userFullname,
          time: time,
          date: date,
          status: tripStatus,
          sourceStation: startingStation.startingPointName,
          destinationStation: destinationStation.destinationName);

      historyTrips.add(historyTripCard);
      // print(historyTrips.length);
    }
  }
}
