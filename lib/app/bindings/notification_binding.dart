import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/notification_controller.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(NotificationController());
    CommonFunctions.bind(TripProvider());
  }
}
