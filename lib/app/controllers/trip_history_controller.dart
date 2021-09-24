import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/enums/trip_status_enum.dart';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/starting_station.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/trip_history_provider.dart';
import 'package:bikes_user/app/ui/android/pages/trip_history/trip_history_page.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/history_trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Manage states of [TripHistoryPage]
class TripHistoryController extends GetxController {
  final TripHistoryProvider _tripHistoryProvider =
      Get.put(TripHistoryProvider());

  RxList<dynamic> historyTrips = [].obs;
  Rx<Role> role = Role.keer.obs;

  /// Load history trips from API based on [userId] and [role].
  ///
  /// Author: TamNTT
  Future<void> getHistoryTrips(
      {required BuildContext context,
      required int userId,
      required int role}) async {
    historyTrips.clear();
    List response =
        await _tripHistoryProvider.getHistoryTrips(userId: userId, role: role);
    print(response);

    for (var historyTrip in response) {
      // print(item);
      User user = User.fromJson(historyTrip);
      // print(user.toJson());
      Trip trip = Trip.fromJson(historyTrip);
      // print(trip.toJson());
      StartingStation startingStation = StartingStation.fromJson(historyTrip);
      // print(startingStation.toJson());
      DestinationStation destinationStation =
          DestinationStation.fromJson(historyTrip);
      // print(destinationStation.toJson());
      TripStatus tripStatus;
      String date = trip.timeBook.day.toString() +
          ' Th ' +
          trip.timeBook.month.toString();

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
          time: DateFormat('HH:mm').format(trip.timeBook),
          date: date,
          status: tripStatus,
          sourceStation: startingStation.startingPointName,
          destinationStation: destinationStation.destinationName);

      historyTrips.add(historyTripCard);
      // print(historyTrips.length);
    }
  }
}
