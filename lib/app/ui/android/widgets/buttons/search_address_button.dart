import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAddressButton extends StatelessWidget {
  const SearchAddressButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1.0,
      onPressed: () => Get.toNamed(CommonRoutes.SEARCH_ADDRESS),
      backgroundColor: Colors.white,
      foregroundColor: CustomColors.kBlue,
      child: Icon(
        Icons.add,
        size: 50,
      ),
    );
  }
}
