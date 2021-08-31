import 'package:bikes_user/pages/home/controller/home_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget shows the finish trip button
class FinishTripButton extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 152,
      child: Obx(
        () => ElevatedButton.icon(
            onPressed: () {
              homeController.setAtDestination();
            },
            icon: Icon(Icons.done_all, size: 25),
            label: Text(
              homeController.isAtDestination.value
                  ? CustomStrings.kFinishTrip
                  : CustomStrings.kConfirmFinishTrip,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                elevation: MaterialStateProperty.all<double>(0.0),
                backgroundColor: homeController.isAtDestination.value
                    ? MaterialStateProperty.all<Color>(CustomColors.kDarkGray)
                    : MaterialStateProperty.all<Color>(CustomColors.kBlue))),
      ),
    );
  }
}
