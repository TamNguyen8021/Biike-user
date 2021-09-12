import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewTripButton extends StatelessWidget {
  const ViewTripButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Get.toNamed('/tripDetails'),
        child: Text(
          CustomStrings.kViewTrip,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.kBlue),
            elevation: MaterialStateProperty.all<double>(0.0)),
      ),
    );
  }
}