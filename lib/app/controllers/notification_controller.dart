import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/trip_status_enum.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/trip_feedback.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/services/firebase_realtime_database_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  FirebaseRealtimeDatabaseService _databaseService =
      getIt<FirebaseRealtimeDatabaseService>();
  final _tripProvider = Get.find<TripProvider>();

  RxMap listNoti = {}.obs;
  bool isKeer = false;

  Future<void> getNoti() async {
    _databaseService.getNotifications(
        userId: Biike.userId.value, data: listNoti);
  }

  Future<void> updateNoti({required hashKey, required isRead}) async {
    if (!isRead)
      await _databaseService.updateNotification(
          userId: Biike.userId.value, hashKey: hashKey);
  }

  Future<void> deleteNoti() async {
    await _databaseService.deleteAllNotification(userId: Biike.userId.value);
  }

  Future<String> isMoveToFeedBack(tripId) async {
    var data = await _tripProvider.getTripDetails(tripId: tripId);
    var trip = Trip.fromJson(data);

    // is cancel
    if (trip.tripStatus == TripStatus.canceled.index) {
      return CustomErrorsString.kTripCanceled.tr;
    }

    if (data['feedbacks'].length > 0) {
      var feedback1 = TripFeedback.fromJson(data['feedbacks'][0]);
      var feedback2;
      try {
        feedback2 = TripFeedback.fromJson(data['feedbacks'][1]);
      } catch (e) {
        CommonFunctions.logBiike(error: 'This trip currently has only 1 feedback');
        feedback2 = null;
      }

      // đã feedback
      if ((feedback1.userId != null &&
              Biike.userId.value == feedback1.userId) ||
          (feedback2 != null &&
              Biike.userId.value == feedback2.userId)) {
        return CustomErrorsString.kAlreadyFeedbacked.tr;
      }
    }

    // check is user keer on that trip
    isKeer = (trip.keerId == Biike.userId.value);

    return '';
  }
}
