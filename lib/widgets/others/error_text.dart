import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errorText;

  const ErrorText({Key? key, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        errorText,
        style: TextStyle(
          color: CustomColors.kRed,
        ),
      ),
    );
  }
}
