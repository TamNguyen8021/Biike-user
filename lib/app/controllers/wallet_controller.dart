import 'package:bikes_user/app/data/models/wallet.dart';
import 'package:bikes_user/app/data/providers/wallet_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class WalletController extends GetxController {
  final _walletProvider = Get.find<WalletProvider>();

  Rx<int> totalWalletPoint = 0.obs;

  Future<List<Wallet>> getUserWalletsList() async {
    return (await _walletProvider.getUserWalletList(userId: Biike.userId.value)
            as List)
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
