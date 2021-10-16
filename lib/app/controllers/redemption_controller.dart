import 'package:bikes_user/app/data/providers/redemption_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class RedemptionController extends GetxController {
  RxList<dynamic> yourVoucherList = [].obs;

  Future<dynamic> exchangeVoucher(voucherId) async {
    Map<String, dynamic> data = <String, dynamic>{
      'userId': await Biike.localAppData.userId,
      'voucherId': voucherId
    };

    return await RedemptionProvider().exchangeVoucher(data);
  }

  Future<void> getYourVoucherList() async {
    yourVoucherList.value = await RedemptionProvider()
        .getYourVoucherList(userId: await Biike.localAppData.userId);
  }

  Future<Map<String, dynamic>> getRedemptionDetailByRedemptionId(
      redemptionId) async {
    return await RedemptionProvider()
        .getRedemptionDetailByRedemptionId(redemptionId);
  }
}
