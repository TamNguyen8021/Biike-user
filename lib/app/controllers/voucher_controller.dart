import 'package:bikes_user/app/data/providers/voucher_provider.dart';
import 'package:get/get.dart';

class VoucherController extends GetxController {
  RxList<dynamic> voucherList = [].obs;

  Future<void> getVoucherList() async {
    VoucherProvider provider = new VoucherProvider();
    voucherList.value = await provider.getVoucherList();
  }
}