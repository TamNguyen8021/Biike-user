import 'package:bikes_user/main.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {
          Biike.role.value == Role.Customer
            ? Get.offAllNamed('/customerHome')
            : Get.offAllNamed('/driverHome')
        },
        child: Text(
          CustomStrings.kBtnExit,
          style: TextStyle(
              color: CustomColors.kDarkGray,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation: MaterialStateProperty.all<double>(0.0)),
      ),
    );
  }
}
