import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopUpPointTextField extends StatelessWidget {
  final bool isReadOnly;
  final bool isEditPoint;
  final String initialValue;
  final String labelText;
  final String hintText;
  final Function(String)? onChangeFunc;

  const TopUpPointTextField(
      {Key? key,
        required this.isReadOnly,
        required this.isEditPoint,
        required this.initialValue,
        required this.labelText,
        required this.hintText,
        this.onChangeFunc
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: TextFormField(
        readOnly: isReadOnly,
        initialValue: initialValue,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        onChanged: onChangeFunc,
        style: TextStyle( 
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
            color: CustomColors.kDarkGray
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: CustomColors.kDarkGray.withOpacity(0.3)
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.all(
                const Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.white, width: 0.0),
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
