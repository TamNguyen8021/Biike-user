import 'package:bikes_user/app/common/functions/common_functions.dart';
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
    CommonFunctions.bind(VoucherProvider());
    CommonFunctions.bind(RedemptionProvider());
    CommonFunctions.bind(WalletProvider());
    CommonFunctions.bind(VoucherCategoryProvider());
    CommonFunctions.bind(VoucherController());
    CommonFunctions.bind(RedemptionController());
    CommonFunctions.bind(WalletController());
  }
}
