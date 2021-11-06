import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/redemption_controller.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/redeemed_voucher_list/widget/your_voucher_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UsedVoucherPage extends StatelessWidget {
  UsedVoucherPage({Key? key}) : super(key: key);

  final _redemptionController = Get.find<RedemptionController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _redemptionController,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 230,
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                  () => _redemptionController.usedVoucherPagingController
                      .refresh(),
                ),
                child: PagedListView<int, dynamic>(
                  pagingController:
                      _redemptionController.usedVoucherPagingController,
                  builderDelegate: PagedChildBuilderDelegate<dynamic>(
                      itemBuilder: (context, item, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: YourVoucherCard(
                                data: _redemptionController
                                    .usedVoucherPagingController.itemList!
                                    .elementAt(index)),
                          ),
                      noItemsFoundIndicatorBuilder: (BuildContext context) {
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
