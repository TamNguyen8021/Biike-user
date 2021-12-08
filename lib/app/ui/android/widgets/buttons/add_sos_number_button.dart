import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSOSNumberButton extends StatelessWidget {
  final bool isDisable;

  const AddSOSNumberButton(
      {
        Key? key,
        required this.isDisable
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1.0,
      onPressed: isDisable ? () {} : () => Get.toNamed(CommonRoutes.ADD_SOS_NUMBER),
      backgroundColor: isDisable ? CustomColors.kDarkGray : CustomColors.kDarkBlue,
      child: Icon(
        Icons.add,
        size: 50,
      ),
    );
  }
}
