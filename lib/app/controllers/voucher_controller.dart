import 'package:bikes_user/app/data/providers/redemption_provider.dart';
import 'package:bikes_user/app/data/providers/voucher_provider.dart';
import 'package:get/get.dart';

class VoucherController extends GetxController {
  RxList<dynamic> _voucherList = [].obs;
  RxList<dynamic> _yourVoucherList = [].obs;

  List<dynamic> getVoucherList() {
    VoucherProvider provider = new VoucherProvider();
    provider.getVoucherList()
        .then((list) =>
            {_voucherList.value = list});

    return _voucherList.value;
  }
  //
  // List<dynamic> getYourVoucherList() {
  //   // _voucherList.clear();
  //   RedemptionProvider provider = new RedemptionProvider();
  //   provider.getYourVoucherList()
  //       .then((list) =>
  //   {_yourVoucherList.value = list});
  //
  //   return _voucherList.value;
  // }
}