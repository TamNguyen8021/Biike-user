import 'package:bikes_user/main.dart';
import 'package:bikes_user/pages/home/view/home_page.dart';
import 'package:bikes_user/pages/trip_details/view/trip_details_page.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptTripButton extends StatelessWidget {
  AcceptTripButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          Get.offAllNamed("/getTripSuccess");
        },
        child: Text(
          CustomStrings.kAcceptTrip,
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.kBlue),
            elevation: MaterialStateProperty.all<double>(0.0)),
      ),
    );
  }
}
