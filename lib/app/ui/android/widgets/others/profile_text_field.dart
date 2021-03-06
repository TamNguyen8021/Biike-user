import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final bool isReadOnly;
  final bool isEditProfile;
  final String initialValue;
  final String labelText;
  final Function(String)? onChangedFunc;

  const ProfileTextField({
    Key? key,
    required this.isReadOnly,
    required this.isEditProfile,
    required this.initialValue,
    required this.labelText,
    this.onChangedFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      initialValue: initialValue,
      onChanged: onChangedFunc,
      style: isReadOnly && isEditProfile
          ? Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: CustomColors.kDarkGray.withOpacity(0.5))
          : Theme.of(context).textTheme.headline6,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: isReadOnly && isEditProfile
            ? TextStyle(color: CustomColors.kDarkGray.withOpacity(0.5))
            : null,
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
