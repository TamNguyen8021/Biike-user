import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/redeemed_voucher_list/used_voucher_page.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/voucher_list/exchange_voucher_page.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/redeemed_voucher_list/your_vouchers_page.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VoucherPage extends StatelessWidget {
  VoucherPage({Key? key}) : super(key: key);

  final _walletController = Get.find<WalletController>();

  TabBar _getTabBar(context) => TabBar(
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: CustomColors.kLightGray
      ),
      indicatorPadding: const EdgeInsets.symmetric(vertical: 5.0),
      tabs: [
        Container(
          width: MediaQuery.of(context).size.width/3,
          child: Text(
            CustomStrings.kCanExchange.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10.0.sp),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width/3,
          child: Text(
            CustomStrings.kExchanged.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10.0.sp),
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width/3,
          child: Text(
            CustomStrings.kUsedOrExpired.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10.0.sp),
          ),
        ),

      ]
  );
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: FutureBuilder(
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
                        child: Obx(() =>
                          Text.rich(
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
                                  )
                              )
                            ]),
                          ),
                        ),
                      ),
                    )
                  ],
                  bottomAppBar: PreferredSize(
                    preferredSize: _getTabBar(context).preferredSize,
                    child: Container(
                      // height: 50.0.sp,
                      child: _getTabBar(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: CustomColors.kLightGray),
                        ),
                      ),
                    ),
                  )
                ),
                body: SafeArea(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      ExchangeVoucherPage(),
                      YourVoucherPage(),
                      UsedVoucherPage(),
                    ],
                  )
                ),
              );
            } else {
              return Loading();
            }
          }
        )
    );
  }
}