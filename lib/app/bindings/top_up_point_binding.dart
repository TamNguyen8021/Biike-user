import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/top_up_point_controller.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/providers/top_up_point_provider.dart';
import 'package:bikes_user/app/data/providers/wallet_provider.dart';
import 'package:get/get.dart';

class TopUpPointBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(TopUpPointProvider());
    CommonFunctions.bind(TopUpPointController());
    CommonFunctions.bind(WalletController());
    CommonFunctions.bind(WalletProvider());
  }
}
