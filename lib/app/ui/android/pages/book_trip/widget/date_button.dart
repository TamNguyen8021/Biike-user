import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateButton extends StatelessWidget {
  final DateTime date;
  final _bookTripController = Get.find<BookTripController>();

  DateButton({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<Color> buttonColor = CustomColors.kLightGray.obs;
    Rx<bool> isSelected = false.obs;

    return Obx(
      () => GestureDetector(
        child: Container(
          width: 40.sp,
          height: 40.sp,
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          margin: const EdgeInsets.only(right: 5.0, bottom: 3.0),
          decoration: BoxDecoration(
            color: buttonColor.value,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: CustomColors.kDarkGray.withOpacity(0.3),
                // changes position of shadow
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: <Widget>[
              Text(
                date.day.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              Text(
                // date.month.toString(),
                CommonFunctions.getMonthText(date.month),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 8.sp),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        onTap: () {
          isSelected.value = !isSelected.value;

          if (isSelected.isTrue) {
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
