import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/search_address_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 'first_save_address' screen
class FirstSaveAddressPage extends StatelessWidget {
  const FirstSaveAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/line-map.png"),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      CustomColors.kLightGray.withOpacity(0.5),
                      BlendMode.dstIn))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 100.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text(CustomStrings.kLater.tr,
                            style:
                            TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 16.0
                            )
                        ),
                        onPressed: () {
                          Get.offAllNamed(CommonRoutes.HOME);
                        },
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 20.0),
                  child: Text(
                    CustomStrings.kSaveAddressFirstDescription.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30.0),
                    child: Text(
                        CustomStrings.kSaveAddressSecondDescription.tr,
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white.withOpacity(0.6))
                    ),
                )
              ],
            ),
          )),
      floatingActionButton: SearchAddressButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
