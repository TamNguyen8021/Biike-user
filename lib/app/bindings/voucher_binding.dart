import 'package:bikes_user/app/controllers/redemption_controller.dart';
import 'package:bikes_user/app/controllers/voucher_controller.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/providers/redemption_provider.dart';
import 'package:bikes_user/app/data/providers/voucher_category_provider.dart';
import 'package:bikes_user/app/data/providers/voucher_provider.dart';
import 'package:bikes_user/app/data/providers/wallet_provider.dart';
import 'package:get/get.dart';

class VoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VoucherProvider());
    Get.put(RedemptionProvider());
    Get.put(WalletProvider());
    Get.put(VoucherCategoryProvider());
    Get.lazyPut<VoucherController>(() => VoucherController());
    Get.lazyPut<RedemptionController>(() => RedemptionController());
    Get.lazyPut<WalletController>(() => WalletController());
  }
}
