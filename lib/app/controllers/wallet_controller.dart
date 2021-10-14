import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:bikes_user/app/data/models/wallet.dart';
import 'package:bikes_user/app/data/providers/wallet_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class WalletController extends GetxController {
  Rx<int> totalWalletPoint = 0.obs;

  Future<void> getTotalWalletPoint() async {
    List<Wallet> walletList = (await new WalletProvider()
        .getUserWalletList(userId: await new LocalAppData().userId) as List)
        .map((e) => Wallet.fromJson(e))
        .toList();

    for(Wallet wallet in walletList) {
      totalWalletPoint.value += wallet.point ?? 0;
    }
  }

  bool isNotEnoughPoint({required int voucherPoint}) {
    return voucherPoint > totalWalletPoint.value;
  }

  void updateWalletPoint() {
    totalWalletPoint.value = 0;
    getTotalWalletPoint();
  }
}