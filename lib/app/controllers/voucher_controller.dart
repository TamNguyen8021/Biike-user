import 'package:bikes_user/app/data/providers/voucher_provider.dart';
import 'package:get/get.dart';

class VoucherController extends GetxController {
  final _voucherProvider = Get.find<VoucherProvider>();
  RxList<dynamic> voucherList = [].obs;

  Future<void> getVoucherList() async {
    voucherList.value = await _voucherProvider.getVoucherList();
  }
}
