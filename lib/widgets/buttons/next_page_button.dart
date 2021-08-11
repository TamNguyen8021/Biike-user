import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class NextPageButton extends StatelessWidget {
  final String route;

  const NextPageButton({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, route);
      },
      backgroundColor: Colors.white,
      foregroundColor: CustomColors.kBlue,
      child: Icon(
        Icons.arrow_forward_ios,
        size: 25,
      ),
    );
  }
}
