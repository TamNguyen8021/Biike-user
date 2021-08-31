import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final bool isReadOnly;
  final String initialValue;
  final String labelText;

  const ProfileTextField(
      {Key? key,
      required this.isReadOnly,
      required this.initialValue,
      required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      initialValue: initialValue,
      style: Theme.of(context).textTheme.headline6,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: CustomColors.kDarkGray.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: CustomColors.kDarkGray.withOpacity(0.2))),
        errorBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: CustomColors.kDarkGray.withOpacity(0.2))),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: CustomColors.kDarkGray.withOpacity(0.2))),
      ),
    );
  }
}
