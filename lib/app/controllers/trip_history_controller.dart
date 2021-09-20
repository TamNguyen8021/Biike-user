import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/enums/trip_status_enum.dart';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/starting_station.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/ui/android/pages/trip_history/trip_history_page.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/history_trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

/// Manage states of [TripHistoryPage]
class TripHistoryController extends GetxController {
  // final tripHistoryProvider = Get.find<TripHistoryProvider>();

  RxList<dynamic> historyTrips = [].obs;
  Rx<Role> role = Role.keer.obs;

  /// Load history trips from json file.
  ///
  /// Author: TamNTT
  Future<void> getHistoryTrips({required BuildContext context}) async {
    historyTrips.clear();
    String response = await DefaultAssetBundle.of(context)
        .loadString('assets/files/history_trip.json');
    var data = jsonDecode(response);
    var tempHistoryTrips = data;
    // print('tempHistoryTrips: ' + tempHistoryTrips.toString());
    for (var item in tempHistoryTrips) {
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
          tripStatus = TripStatus.finding;
          break;
        case 2:
          tripStatus = TripStatus.waiting;
          break;
        case 3:
          tripStatus = TripStatus.started;
          break;
        case 4:
          tripStatus = TripStatus.finished;
          break;
        case 5:
          tripStatus = TripStatus.canceled;
          break;
        default:
          tripStatus = TripStatus.none;
          Get.defaultDialog(
              title: CustomErrorsString.kError.tr,
              middleText: CustomErrorsString.kErrorMessage.tr);
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
