import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBiker extends StatelessWidget {
  const TopBiker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentMonth = DateTime.now().month.toString();

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
            color: CustomColors.kLightBlue,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Image.asset(
                'assets/images/top-rated.png',
                height: 20,
              ),
            ),
            Expanded(
                child: Text(
              CustomStrings.kTopBiker.tr + currentMonth,
            )),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 20,
              ),
            )
          ],
        ));
  }
}
