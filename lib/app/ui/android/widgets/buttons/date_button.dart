import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/data/enums/date_enum.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateButton extends StatelessWidget {
  final Date date;
  final _bookTripController = Get.find<BookTripController>();

  DateButton({Key? key, required this.date}) : super(key: key);

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
            date.getDateText(date.index),
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
            _bookTripController.addToDateList(date);
          } else {
            buttonColor.value = CustomColors.kLightGray;
            _bookTripController.removeFromDateList(date);
          }
        },
      ),
    );
  }
}
