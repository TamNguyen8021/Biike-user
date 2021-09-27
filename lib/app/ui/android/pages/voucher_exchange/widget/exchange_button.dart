import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeVoucherButton extends StatelessWidget {
  const ExchangeVoucherButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, //match_parent
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          CustomStrings.kExchangeNow.tr,
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 35.0)
            ),
            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.kBlue),
            elevation: MaterialStateProperty.all<double>(0.0)
        ),
      ),
    );
  }
}