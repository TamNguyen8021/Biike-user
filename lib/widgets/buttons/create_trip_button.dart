import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTripButton extends StatelessWidget {
  const CreateTripButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1.0,
      onPressed: () => Get.toNamed('/bookTrip'),
      backgroundColor: CustomColors.kOrange,
      child: Icon(
        Icons.add,
        size: 50,
      ),
    );
  }
}
