import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class SOSNumberTextField extends StatelessWidget {
  final bool isReadOnly;
  final bool isEditSOSNumber;
  final String initialValue;
  final String labelText;
  final String hintText;
  final TextInputType inputType;
  final Function(String)? onChangedFunc;

  const SOSNumberTextField(
      {Key? key,
      required this.isReadOnly,
      required this.isEditSOSNumber,
      required this.initialValue,
      required this.labelText,
      required this.hintText,
      required this.inputType,
      this.onChangedFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 5.0),
      child: TextFormField(
        readOnly: isReadOnly,
        initialValue: initialValue,
        onChanged: onChangedFunc,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: inputType,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
            color: CustomColors.kDarkGray),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: CustomColors.kDarkGray.withOpacity(0.3)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.all(const Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
          ),
          filled: true,
          fillColor: CustomColors.kLightGray,
        ),
      ),
    );
  }
}
