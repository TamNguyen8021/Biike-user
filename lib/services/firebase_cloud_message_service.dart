import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

/// receives msg when app is on bg
Future<void> backgroundHandler(RemoteMessage message) async {
  CommonFunctions.logBiike(error: message.notification.toString());
}

class FirebaseCloudMessagingService {
  late FirebaseMessaging _fcm;

  static FirebaseCloudMessagingService init() {
    FirebaseCloudMessagingService _cloudService =
        FirebaseCloudMessagingService();

    _cloudService._fcm = FirebaseMessaging.instance;
    return _cloudService;
  }

  /// Handle
  ///
  /// Author: UyenNLP
  onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  /// Listen to new message from Firebase
  ///
  /// Author: UyenNLP
  listen() {
    /// gives you the msg on which user taps
    /// and it opens the app from terminated state
    _fcm.getInitialMessage().then((msg) {
      if (msg != null) Get.toNamed(CommonRoutes.NOTIFICATION);
    });

    /// handles msg when app in on the foreground
    FirebaseMessaging.onMessage.listen((msg) {
      try {
        if (msg.notification != null) {
          CommonFunctions.moveToNotiPageWhenHasNoti(
              msg.notification!.title, msg.notification!.body);
        }
      } catch (e) {
        CommonFunctions.catchExceptionError(e);
      }
    });

    /// handles msg when app in on the background
    /// but is still open
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      if (msg.notification != null) {
        Biike.logger.d(msg.notification!.title);
        Get.toNamed(CommonRoutes.NOTIFICATION);
      }
    });
  }

  /// get device token of this account to send
  /// push noti to
  ///
  /// Author: UyenNLP
  Future<String> get token async {
    try {
      var fcmToken = await _fcm.getToken();

      return fcmToken ?? '';
    } catch (e) {
      CommonFunctions.catchExceptionError(e);
      return '';
    }
  }
}
