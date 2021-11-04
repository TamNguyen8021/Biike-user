import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/controllers/voucher_controller.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/list_vouchers.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/voucher_card.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
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
        return FutureBuilder(
            future: _walletController.updateWalletPoint(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Scaffold(
                  appBar: CustomAppBar(
                    isVisible: true,
                    hasShape: true,
                    hasLeading: true,
                    onPressedFunc: () async {
                      await _walletController.updateWalletPoint();
                      Get.back();
                    },
                    appBar: AppBar(),
                    title: Text(CustomStrings.kListVouchers.tr),
                    actionWidgets: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 17.0, horizontal: 22.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 4.0),
                          decoration: BoxDecoration(
                              color: CustomColors.kOrange,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: CustomColors.kDarkGray.withOpacity(0.3),
                                  // changes position of shadow
                                  offset: Offset(0, 1.5),
                                )
                              ]),
                          child: Obx(
                                () => Text.rich(
                              TextSpan(children: <InlineSpan>[
                                TextSpan(
                                    text: _walletController.totalWalletPoint
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 11.sp, color: Colors.white)),
                                WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    )),
                                WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 2.0),
                                      child: SvgPicture.asset(
                                        'assets/images/crown.svg',
                                        height: 10.sp,
                                        color: Colors.white,
                                      ),
                                    ))
                              ]),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  body: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(CommonRoutes.YOUR_VOUCHERS);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin:
                            const EdgeInsets.fromLTRB(
                                22.0, 16.0, 22.0, 10.0),
                            decoration: BoxDecoration(
                              color: CustomColors.kBlue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    CustomStrings.kTradedVouchers.tr,
                                    style: TextStyle(
                                        color: Colors.white),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 22.0, right: 22.0),
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
                                      return Text(CustomStrings.kNoUpcomingTrips.tr);
                                    }),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Loading();
              }
            }
        );
      }
    );
  }
}
