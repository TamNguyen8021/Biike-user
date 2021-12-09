import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BiikeProfileController extends GetxController {
  final _userProvider = Get.find<UserProvider>();

  String noOfRideTrips = '';
  String noOfFreeTrips = '';
  String noOfKm = '';
  String noOfGasLitres = '';

  Future<void> getUserAchievement() async {
    Map<String, dynamic> data = await _userProvider.getUserAchievement();
    NumberFormat numberFormat = NumberFormat.decimalPattern();
    noOfRideTrips = numberFormat.format(data['totalBikerTrip']);
    noOfFreeTrips = numberFormat.format(data['totalKeerTrip']);
    noOfKm = numberFormat.format(data['totalKmSaved']);
    noOfGasLitres = numberFormat.format(data['totalFuelSaved']);
  }
}
