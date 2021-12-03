import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/voucher_controller.dart';
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
    return GetBuilder(
        init: _voucherController,
        builder: (_) {
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
                            FutureBuilder(
                              future:
                                  _voucherController.getVoucherCategoryList(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Container();
                                } else if (snapshot.connectionState ==
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          NearMeButton(),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 230,
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => _voucherController.pagingController.refresh(),
                    ),
                    child: PagedListView<int, dynamic>(
                      pagingController: _voucherController.pagingController,
                      shrinkWrap: true,
                      builderDelegate: PagedChildBuilderDelegate<dynamic>(
                          itemBuilder: (context, item, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: VoucherCard(
                                    data: _voucherController
                                        .pagingController.itemList!
                                        .elementAt(index)),
                              ),
                          noItemsFoundIndicatorBuilder: (BuildContext context) {
                            return Text(CustomErrorsString.kNoVoucher.tr);
                          },
                          firstPageErrorIndicatorBuilder:
                              (BuildContext context) {
                            return LazyLoadingListErrorBuilder(onPressed: () {
                              _voucherController.pagingController.refresh();
                            });
                          }),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
