import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/data/providers/voucher_provider.dart';
import 'package:get/get.dart';

class VoucherController extends GetxController {
  RxList<dynamic> _voucherList = [].obs;

  List<dynamic> getVoucherList() {
    VoucherProvider provider = new VoucherProvider();
    provider.getVoucherList()
        .then((list) =>
            {_voucherList.value = list});

    return _voucherList.value;
  }
}