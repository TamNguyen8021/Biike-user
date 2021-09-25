import 'package:bikes_user/app/controllers/voucher_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_vouchers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExchangeVoucherPage extends StatelessWidget {
  ExchangeVoucherPage({Key? key}) : super(key: key);

  final voucherController = Get.find<VoucherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        appBar: AppBar(),
        title: Text(CustomStrings.kListVouchers.tr),
        actionWidgets: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 17.0, horizontal: 22.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
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
              child: Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: '1000',
                    style: TextStyle(fontSize: 11, color: Colors.white)),
                WidgetSpan(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                )),
                WidgetSpan(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: SvgPicture.asset(
                    'assets/images/crown.svg',
                    height: 10,
                    color: Colors.white,
                  ),
                ))
              ])),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.fromLTRB(22.0, 16.0, 22.0, 10.0),
              decoration: BoxDecoration(
                color: CustomColors.kBlue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      CustomStrings.kTradedVouchers.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
              child:
                  Obx(() =>
                      // ListVouchers(listVouchers: [1, 2, 3, 4, 5, 6]),
                    ListVouchers(listVouchers: voucherController.getVoucherList()),
                  ),
            ),
          ],
        ),
      )),
    );
  }
}
