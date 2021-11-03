import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/pages/view_point/widget/buy_point_button.dart';
import 'package:bikes_user/app/ui/android/pages/view_point/widget/view_voucher_button.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        onPressedFunc: () async {
          Get.back();
        },
        appBar: AppBar(),
        title: Text(CustomStrings.kPoint.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                  children: <Widget> [
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
                                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '123 ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: CustomColors.kOrange, fontWeight: FontWeight.bold),
                                ),
                                SvgPicture.asset(
                                  'assets/images/crown.svg',
                                  color: CustomColors.kOrange,
                                  height: 18.sp,
                                ),
                              ],
                            ),
                            Text(
                              '222${CustomStrings.kExpired.tr}12/12/2020',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!,
                              overflow: TextOverflow.clip,
                            ),
                            Text(
                              CustomStrings.kFindMore.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: CustomColors.kBlue),
                            ),
                          ]
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        BuyPointButton(),
                        ViewVoucherButton(),
                      ],
                    ),
                  ]
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

}