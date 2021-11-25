import 'dart:math';

import 'package:bikes_user/app/data/models/notification.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/services/firebase_realtime_database_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  FirebaseRealtimeDatabaseService _databaseService =
      getIt<FirebaseRealtimeDatabaseService>();
  RxList listNoti = [].obs;

  void sendNoti(data) async {
    BiikeNoti notification = BiikeNoti(
        receiverId: Biike.userId.value,
        title: 'title',
        content: 'content',
        url: 'url',
        createdDate: DateTime.now());

    await _databaseService.sendNotification(
        receiverId: Biike.userId.value, notification: notification);
  }

  Future<void> updateNoti() async {
    _databaseService.updateNotification(
        userId: Biike.userId.value, data: listNoti);
  }
}
