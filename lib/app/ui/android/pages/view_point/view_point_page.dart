import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/ui/android/pages/view_point/widget/buy_point_button.dart';
import 'package:bikes_user/app/ui/android/pages/view_point/widget/point_list.dart';
import 'package:bikes_user/app/ui/android/pages/view_point/widget/view_voucher_button.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewPointPage extends StatelessWidget {
  ViewPointPage({Key? key}) : super(key: key);

  final _walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return OnBackPressed(
        child: Scaffold(
          appBar: CustomAppBar(
            hasShape: true,
            hasLeading: true,
            onPressedFunc: () => Get.back(),
            appBar: AppBar(),
            title: Text(CustomStrings.kPoint.tr),
          ),
          body: FutureBuilder(
            future: _walletController.updateWalletPoint(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    CustomStrings.kYouHave.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Obx(() => Text(
                                            '${_walletController.totalWalletPoint.value} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                    color:
                                                        CustomColors.kOrange),
                                          )),
                                      SvgPicture.asset(
                                        'assets/images/crown.svg',
                                        color: CustomColors.kOrange,
                                        height: 18.sp,
                                      ),
                                    ],
                                  ),
                                  FutureBuilder(
                                      future: _walletController
                                          .updateUpcomingExpiredWallet(),
                                      builder:
                                          (BuildContext context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          var wallet = _walletController
                                              .expiringWallet.value;
                                          if (wallet.walletId == -1) {
                                            return Container();
                                          } else {
                                            return Text(
                                              '${wallet.point}${CustomStrings.kExpired.tr}${wallet.toDate}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!,
                                              overflow: TextOverflow.clip,
                                            );
                                          }
                                        } else {
                                          return Loading();
                                        }
                                      }),
                                  Text(
                                    CustomStrings.kFindMore.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: CustomColors.kBlue),
                                  ),
                                ]),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              BuyPointButton(),
                              ViewVoucherButton(),
                            ],
                          ),
                        ]),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 22.0, right: 22.0),
                        child: PointList(),
                      ),
                    ],
                  ),
                );
              } else {
                return Loading();
              }
            },
          ),
        ),
        perform: () => Get.back());
  }
}
