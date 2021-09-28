import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(CommonRoutes.ADDRESS_BOOK);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.import_contacts,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Text(
                    CustomStrings.kSavedAddress.tr,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                  Get.toNamed(CommonRoutes.APP_SETTING);
                },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.settings,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Text(
                    CustomStrings.kSettings.tr,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(CommonRoutes.BAN_LIST);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.remove_circle,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Text(
                    CustomStrings.kBlockList.tr,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(CommonRoutes.SOS_NUMBER);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.dialpad,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Text(
                    CustomStrings.kSOS.tr,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.help,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Text(
                    CustomStrings.kHelp.tr,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.star,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      CustomStrings.kRateApp.tr,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      'v1.0.1',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 9.sp),
                    ),
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
      ],
    );
  }
}
