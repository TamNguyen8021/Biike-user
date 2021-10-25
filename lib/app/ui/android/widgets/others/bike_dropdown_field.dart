import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class BikeDropdownField extends StatelessWidget {
  final String hintText;
  final Function(dynamic)? onChangedFunc;
  final List items;

  const BikeDropdownField(
      {Key? key,
        required this.items,
        required this.hintText,
        this.onChangedFunc,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 5.0),
      child: DropdownButtonFormField(
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
