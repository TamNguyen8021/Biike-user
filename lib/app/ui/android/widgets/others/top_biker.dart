import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TopBiker extends StatelessWidget {
  const TopBiker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale appLocale = Get.locale!;
    String currentMonth = DateTime.now().month.toString();
    if (appLocale == Locale('en', 'US')) {
      currentMonth = DateFormat.MMMM().format(DateTime.now());
    }

    return GestureDetector(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
              color: CustomColors.kLightBlue,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Image.asset(
                  'assets/images/top-rated.png',
                  height: 20,
                ),
              ),
              Expanded(
                  child: Text(
                CustomStrings.kTopBiker.tr + ' ' + currentMonth,
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20,
                ),
              )
            ],
          )),
      onTap: () => Get.toNamed(CommonRoutes.TOP_BIKER),
    );
  }
}
