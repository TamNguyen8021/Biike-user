import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequireAddBikePage extends StatelessWidget {
  const RequireAddBikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.kBlue,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Image(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 0.6,
                  image: AssetImage('assets/images/line-map.png'),
                  fit: BoxFit.fitWidth,
                  color: CustomColors.kLightGray.withOpacity(0.3),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    CustomStrings.kNeedAddBikeToBecomeBiker.tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CustomElevatedIconButton(
                        width: 140,
                        onPressedFunc: () {
                          Get.offAndToNamed(CommonRoutes.ADD_BIKE, arguments: {
                            'isAddBike': true,
                            'from': 'requireAddBike'
                          });
                        },
                        text: CustomStrings.kAddBike.tr,
                        icon: Icons.two_wheeler,
                        backgroundColor: Colors.white,
                        foregroundColor: CustomColors.kBlue,
                        elevation: 2.0),
                  ),
                  CustomTextButton(
                      width: 140,
                      backgroundColor: Colors.white,
                      foregroundColor: CustomColors.kBlue,
                      text: CustomStrings.kBtnExit.tr,
                      elevation: 2.0,
                      onPressedFunc: () {
                        Get.back();
                      },
                      hasBorder: false),
                ],
              )
            ],
          ),
        ));
  }
}
