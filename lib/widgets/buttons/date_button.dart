import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateButton extends StatelessWidget {
  final String date;

  const DateButton({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<Color> buttonColor = CustomColors.kLightGray.obs;
    Rx<bool> isDateButtonSelected = false.obs;

    return Obx(
      () => GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: buttonColor.value,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: CustomColors.kDarkGray.withOpacity(0.3),
                  // changes position of shadow
                  offset: Offset(0, 2),
                )
              ]),
          child: Text(
            date,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () {
          isDateButtonSelected.value = !isDateButtonSelected.value;
          if (isDateButtonSelected.isTrue) {
            buttonColor.value = CustomColors.kLightBlue;
          } else {
            buttonColor.value = CustomColors.kLightGray;
          }
        },
      ),
    );
  }
}
