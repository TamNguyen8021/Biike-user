import 'package:bikes_user/pages/manage_bike/controller/manage_bike_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/widgets/others/text_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 'add_bike' screen
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
          CustomStrings.kAddBike,
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
                  CustomStrings.kCheckBikeInfo,
                  style: TextStyle(color: CustomColors.kBlue),
                ),
              ),
              Text(CustomStrings.kBikeOwner),
              TextContainer(text: 'Đỗ Hữu Phát'),
              Text(CustomStrings.kBikeBrand),
              TextContainer(text: 'WAVE ALPHA'),
              Text(CustomStrings.kBikeCategory),
              TextContainer(text: 'Yamaha'),
              Text(CustomStrings.kBikeColor),
              TextContainer(text: 'Đỏ-Đen'),
              Text(CustomStrings.kNumberPlate),
              TextContainer(text: '64V1-4170'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 30.0),
                      child: CustomElevatedIconButton(
                        onPressedFunc: () {},
                        text: CustomStrings.kTakePictureAgain,
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
                          Get.offNamed('/manageBike');
                        },
                        text: CustomStrings.kSave,
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
