import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:bikes_user/app/data/providers/redemption_provider.dart';
import 'package:get/get.dart';

class RedemptionController extends GetxController {
  RxList<dynamic> yourVoucherList = [].obs;

  Future<dynamic> exchangeVoucher(voucherId) async {
    Map<String, dynamic> data = <String, dynamic>{
      'userId' : await new LocalAppData().userId,
      'voucherId' : voucherId
    };

    return await new RedemptionProvider().exchangeVoucher(data);
  }

  Future<void> getYourVoucherList() async {
    yourVoucherList.value = await new RedemptionProvider()
        .getYourVoucherList(userId: await new LocalAppData().userId);
  }

  Future<Map<String, dynamic>> getRedemptionDetailByRedemptionId(redemptionId) async {
    return await new RedemptionProvider().getRedemptionDetailByRedemptionId(redemptionId);
  }
}