import 'package:bikes_user/app/data/providers/redemption_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class RedemptionController extends GetxController {
  final _redemptionProvider = Get.find<RedemptionProvider>();
  RxList<dynamic> yourVoucherList = [].obs;

  Future<dynamic> exchangeVoucher(voucherId) async {
    Map<String, dynamic> data = <String, dynamic>{
      'userId': Biike.userId.value,
      'voucherId': voucherId
    };

    return await _redemptionProvider.exchangeVoucher(data);
  }

  Future<void> getYourVoucherList() async {
    yourVoucherList.value = await _redemptionProvider.getYourVoucherList(
        userId: Biike.userId.value);
  }

  Future<Map<String, dynamic>> getRedemptionDetailByRedemptionId(
      redemptionId) async {
    return await _redemptionProvider
        .getRedemptionDetailByRedemptionId(redemptionId);
  }
}
