import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/data/providers/redemption_provider.dart';
import 'package:get/get.dart';

class RedemptionController extends GetxController {
  final _profileController = Get.find<ProfileController>();
  RxList<dynamic> yourVoucherList = [].obs;

  Future<bool> exchangeVoucher(voucherId) {
    Map<String, dynamic> data = <String, dynamic>{
      'userId' : _profileController.user.userId,
      'voucherId' : voucherId
    };

    return new RedemptionProvider().exchangeVoucher(data);
  }

  Future<void> getYourVoucherList() async {
    yourVoucherList.value = await new RedemptionProvider()
        .getYourVoucherList(userId: 10);
  }
}