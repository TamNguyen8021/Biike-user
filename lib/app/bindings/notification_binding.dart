import 'package:bikes_user/app/controllers/manage_bike_controller.dart';
import 'package:bikes_user/app/controllers/notification_controller.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/data/providers/wallet_provider.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<WalletController>(() => WalletController());
    Get.lazyPut<ManageBikeController>(() => ManageBikeController());
    Get.lazyPut<TripDetailsController>(() => TripDetailsController());

    Get.put(TripProvider());
    Get.put(WalletProvider());
    Get.put(BikeProvider());
    Get.put(TripProvider());
  }
}
