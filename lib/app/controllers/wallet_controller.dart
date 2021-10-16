import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:bikes_user/app/data/models/wallet.dart';
import 'package:bikes_user/app/data/providers/wallet_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class WalletController extends GetxController {
  Rx<int> totalWalletPoint = 0.obs;

  Future<List<Wallet>> getUserWalletsList() async {
    return (await WalletProvider()
            .getUserWalletList(userId: await LocalAppData().userId) as List)
        .map((w) => Wallet.fromJson(w))
        .toList();
  }

  Future<void> updateWalletPoint() async {
    List<Wallet> walletList = await getUserWalletsList();

    int total = 0;
    for (Wallet wallet in walletList) {
      total += wallet.point ?? 0;
    }

    totalWalletPoint.value = total;
  }

  bool isNotEnoughPoint({required int voucherPoint}) {
    return voucherPoint > totalWalletPoint.value;
  }
}
