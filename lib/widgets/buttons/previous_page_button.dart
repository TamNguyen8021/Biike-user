import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class PreviousPageButton extends StatelessWidget {
  final String route;

  const PreviousPageButton({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, route);
      },
      backgroundColor: Colors.white,
      foregroundColor: CustomColors.kBlue,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Icon(
          Icons.arrow_back_ios,
          size: 25,
        ),
      ),
    );
  }
}
