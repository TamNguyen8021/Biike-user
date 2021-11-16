import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BikeDropdownField extends StatelessWidget {
  final String hintText;
  final Function(dynamic)? onChangedFunc;
  final List items;
  final String defaultValue;

  const BikeDropdownField({
    Key? key,
    required this.items,
    required this.hintText,
    required this.defaultValue,
    this.onChangedFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 5.0),
      child: DropdownButtonFormField(
        value: defaultValue,
        onChanged: onChangedFunc,
        items: items.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        }).toList(),
        style: TextStyle(color: CustomColors.kDarkGray),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: CustomColors.kDarkGray.withOpacity(0.3), fontSize: 14.sp),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.kLightGray),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          filled: true,
          fillColor: CustomColors.kLightGray,
        ),
      ),
    );
  }
}
