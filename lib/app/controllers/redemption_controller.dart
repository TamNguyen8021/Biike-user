import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/data/providers/redemption_provider.dart';
import 'package:get/get.dart';

class RedemptionController extends GetxController {
  RxList<dynamic> yourVoucherList = [].obs;

  Future<bool> exchangeVoucher(voucherId) async {
    Map<String, dynamic> data = <String, dynamic>{
      'userId' : await new LocalAppData().getUserId(),
      'voucherId' : voucherId
    };

    return new RedemptionProvider().exchangeVoucher(data);
  }

  Future<void> getYourVoucherList() async {
    yourVoucherList.value = await new RedemptionProvider()
        .getYourVoucherList(userId: await new LocalAppData().getUserId());
  }
}