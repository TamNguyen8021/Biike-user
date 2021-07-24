import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1.0,
      onPressed: () {},
      backgroundColor: CustomColors.kOrange,
      child: Icon(
        Icons.add,
        size: 50,
      ),
    );
  }
}
