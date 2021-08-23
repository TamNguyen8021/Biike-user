import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
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
  _ProfileTextFieldState createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.isReadOnly,
      initialValue: widget.initialValue,
      style: Theme.of(context).textTheme.headline6,
      decoration: InputDecoration(
        labelText: widget.labelText,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.kLightGray)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.kLightGray)),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.kLightGray)),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.kLightGray)),
      ),
    );
  }
}
