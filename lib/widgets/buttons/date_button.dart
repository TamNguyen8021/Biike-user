import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class DateButton extends StatefulWidget {
  final String date;
  const DateButton({Key? key, required this.date}) : super(key: key);

  @override
  _DateButtonState createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  bool isSelected = false;
  Color buttonColor = CustomColors.kLightGray;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected ? isSelected = false : isSelected = true;
          isSelected
              ? buttonColor = CustomColors.kLightBlue
              : buttonColor = CustomColors.kLightGray;
        });
      },
      child: Text(widget.date),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        minimumSize: Size(12, 12),
        primary: buttonColor, // <-- Button color
        onPrimary: Colors.black, // <-- Splash color
      ),
    );
  }
}
