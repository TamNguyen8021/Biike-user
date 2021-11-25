import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/redemption_controller.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/redeemed_voucher_list/widget/your_voucher_card.dart';
import 'package:bikes_user/app/ui/android/widgets/others/LazyLoadingListErrorBuilder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UsedVoucherPage extends StatelessWidget {
  UsedVoucherPage({Key? key}) : super(key: key);

  final _redemptionController = Get.find<RedemptionController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RedemptionController>(
        init: _redemptionController,
        builder: (RedemptionController controller) {
          return Container(
            margin: const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => controller.usedVoucherPagingController.refresh(),
              ),
              child: PagedListView<int, dynamic>(
                pagingController: controller.usedVoucherPagingController,
                shrinkWrap: true,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                    animateTransitions: true,
                    itemBuilder: (context, item, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: YourVoucherCard(
                              data: controller
                                  .usedVoucherPagingController.itemList!
                                  .elementAt(index)),
                        ),
                    noItemsFoundIndicatorBuilder: (BuildContext context) {
                      return Text(CustomErrorsString.kNoVoucher.tr);
                    },
                    firstPageErrorIndicatorBuilder: (BuildContext context) {
                      return LazyLoadingListErrorBuilder(onPressed: () {
                        controller.usedVoucherPagingController.refresh();
                      });
                    }),
              ),
            ),
          );
        });
  }
}
