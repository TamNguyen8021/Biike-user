import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressBookButton extends StatelessWidget {
  const AddAddressBookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1.0,
      onPressed: () => Get.toNamed(CommonRoutes.ADD_ADDRESS_BOOK),
      backgroundColor: CustomColors.kDarkBlue,
      child: Icon(
        Icons.add,
        size: 50,
      ),
    );
  }
}
