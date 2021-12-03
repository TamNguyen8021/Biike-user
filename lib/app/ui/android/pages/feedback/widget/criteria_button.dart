import 'package:bikes_user/app/controllers/feedbacks_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CriteriaButton extends StatelessWidget {
  final _feedbackController = Get.find<FeedbackController>();
  final text;

  CriteriaButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Rx<bool> isSelected = false.obs;

    return SizedBox(
      child: Obx(() => ElevatedButton(
            onPressed: () {
              isSelected.value = !isSelected.value;
              _feedbackController.updateCriteria(text,
                  isRemove: isSelected.value);
              _feedbackController.isResetCriteriaField.value = false;
            },
            child: Row(
              children: <Widget>[
                Flexible(
                    child: Container(
                  child: Text(
                    text,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: CustomColors.kDarkGray, fontSize: 10.sp),
                  ),
                ))
              ],
            ),
            style: ElevatedButton.styleFrom(
              primary: (isSelected.value &&
                      !_feedbackController.isResetCriteriaField.value)
                  ? CustomColors.kLightBlue
                  : Colors.white,
              elevation: 0.0,
              side: BorderSide(width: 2.0, color: CustomColors.kLightGray),
            ),
          )),
    );
  }
}
