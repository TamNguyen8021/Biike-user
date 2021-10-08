
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:bikes_user/services/shared_preference_service.dart';
import 'package:get/get.dart';

class OpenPageController extends GetxController {
  static OpenPageController get to => Get.find<OpenPageController>();
  final AppPref _appPref = getIt<AppPref>();
  final FirebaseServices _firebaseServices = getIt<FirebaseServices>();
  Future<void> navigateToWelcomeScreen() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      if (_appPref.initOpenApp) {
        if (_firebaseServices.user != null) {
          Get.offAllNamed(CommonRoutes.HOME);
        } else {
          Get.offAllNamed(CommonRoutes.LOGIN);
        }
        return;
      }
      Get.offAllNamed(CommonRoutes.WELCOME);
      _appPref.setInitOpenApp(true);
    });
  }
}
