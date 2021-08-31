import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              child: SvgPicture.asset(
                'assets/images/top-rated.svg',
                height: 20,
              ),
            ),
            Expanded(
                child: Text(
              CustomStrings.kTopBiker + currentMonth,
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
