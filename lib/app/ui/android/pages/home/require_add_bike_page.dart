import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequireAddBikePage extends StatelessWidget {
  const RequireAddBikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.kBlue,
        body: Stack(
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
              children: <Widget>[
                Text(
                  'Ban can them xe de dung cho mode',
                  style: TextStyle(color: Colors.white),
                ),
                CustomElevatedIconButton(
                    onPressedFunc: () {
                      Get.offAndToNamed(CommonRoutes.ADD_BIKE);
                    },
                    text: CustomStrings.kAddBike.tr,
                    icon: Icons.two_wheeler,
                    backgroundColor: Colors.white,
                    foregroundColor: CustomColors.kBlue,
                    elevation: 2.0)
              ],
            )
          ],
        ));
  }
}
