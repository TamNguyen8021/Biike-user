import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fm = FirebaseMessaging();

  Future init() async {
    if (Platform.isIOS) {
      _fm.
    }
  }
}