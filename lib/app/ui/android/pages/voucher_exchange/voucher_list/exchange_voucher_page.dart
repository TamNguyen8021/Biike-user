import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/voucher_controller.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/voucher_card.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// The screen to view list of vouchers for redeem
class ExchangeVoucherPage extends StatelessWidget {
  ExchangeVoucherPage({Key? key}) : super(key: key);

  final _voucherController = Get.find<VoucherController>();
  final _walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
      init: _voucherController,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 16.0, left: 22.0, right: 22.0),
          child: Container(
            height: MediaQuery.of(context).size.height - 230,
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                    () => _voucherController.pagingController.refresh(),
              ),
              child: PagedListView<int, dynamic>(
                pagingController: _voucherController.pagingController,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                    itemBuilder: (context, item, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: VoucherCard(
                          voucher: Voucher.fromJson(_voucherController
                              .pagingController.itemList!
                              .elementAt(index))),
                    ),
                    noItemsFoundIndicatorBuilder:
                        (BuildContext context) {
                      return Text(CustomErrorsString.kNoVoucher.tr);
                    }),
              ),
            ),
          ),
        );
      }
    );
  }
}
