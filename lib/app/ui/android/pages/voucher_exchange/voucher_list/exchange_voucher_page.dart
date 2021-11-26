import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/voucher_controller.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/voucher_list/widget/category_dropdown_button.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/voucher_list/widget/near_me_button.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/voucher_card.dart';
import 'package:bikes_user/app/ui/android/widgets/others/LazyLoadingListErrorBuilder.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// The screen to view list of vouchers for redeem
class ExchangeVoucherPage extends StatelessWidget {
  ExchangeVoucherPage({Key? key}) : super(key: key);

  final _voucherController = Get.find<VoucherController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FutureBuilder(
                              future:
                                  _voucherController.getVoucherCategoryList(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return CategoryDropdownButton(
                                      dropdownValue:
                                          _voucherController.category.value,
                                      dropdownArray: _voucherController
                                          .voucherCategoryList,
                                      onChangedFunc: (value) =>
                                          _voucherController
                                              .updateCategory(value));
                                } else {
                                  return Loading();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: NearMeButton(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<VoucherController>(
              init: _voucherController,
              builder: (VoucherController controller) {
                return RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => controller.pagingController.refresh(),
                  ),
                  child: PagedListView<int, dynamic>(
                    pagingController: controller.pagingController,
                    shrinkWrap: true,
                    builderDelegate: PagedChildBuilderDelegate<dynamic>(
                        animateTransitions: true,
                        itemBuilder: (context, item, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: VoucherCard(
                                  voucher: Voucher.fromJson(controller
                                      .pagingController.itemList!
                                      .elementAt(index))),
                            ),
                        noItemsFoundIndicatorBuilder: (BuildContext context) {
                          return Text(CustomErrorsString.kNoVoucher.tr);
                        },
                        firstPageErrorIndicatorBuilder: (BuildContext context) {
                          return LazyLoadingListErrorBuilder(onPressed: () {
                            controller.pagingController.refresh();
                          });
                        }),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
