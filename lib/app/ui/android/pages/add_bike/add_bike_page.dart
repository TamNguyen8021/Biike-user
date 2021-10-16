import 'package:bikes_user/app/controllers/manage_bike_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/others/text_container.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'add_bike' screen
class AddBikePage extends StatelessWidget {
  const AddBikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manageBikeController = Get.find<ManageBikeController>();

    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        appBar: AppBar(),
        hasShape: true,
        hasLeading: true,
        title: Text(
          CustomStrings.kAddBike.tr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  CustomStrings.kCheckBikeInfo.tr,
                  style: TextStyle(color: CustomColors.kBlue),
                ),
              ),
              Text(CustomStrings.kBikeOwner.tr),
              TextContainer(text: 'Đỗ Hữu Phát'),
              Text(CustomStrings.kBikeBrand.tr),
              TextContainer(text: 'WAVE ALPHA'),
              Text(CustomStrings.kBikeCategory.tr),
              TextContainer(text: 'Yamaha'),
              Text(CustomStrings.kBikeColor.tr),
              TextContainer(text: 'Đỏ-Đen'),
              Text(CustomStrings.kNumberPlate.tr),
              TextContainer(text: '64V1-4170'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 30.0),
                      child: CustomElevatedIconButton(
                        onPressedFunc: () {},
                        text: CustomStrings.kTakePictureAgain.tr,
                        backgroundColor: CustomColors.kLightGray,
                        foregroundColor: CustomColors.kDarkGray,
                        elevation: 0.0,
                        icon: Icons.photo_camera_outlined,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 30.0),
                      child: CustomElevatedIconButton(
                        onPressedFunc: () {
                          manageBikeController.addBike();
                          Get.back();
                          Get.offNamed(CommonRoutes.MANAGE_BIKE);
                        },
                        text: CustomStrings.kSave.tr,
                        backgroundColor: CustomColors.kBlue,
                        foregroundColor: Colors.white,
                        elevation: 2.0,
                        icon: Icons.save,
                      ),
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
