import 'package:bikes_user/app/ui/android/widgets/buttons/custom_icon_button.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:flutter/material.dart';

/// This widget includes two buttons: call and message
class ContactButtons extends StatelessWidget {
  final String phoneNo;

  const ContactButtons({Key? key, required this.phoneNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: CustomIconButton(
            icon: Icons.phone,
            height: 35.0,
            width: 35.0,
            function: () => CommonFunctions().makingPhoneCall(phoneNo: phoneNo),
          ),
        ),
        CustomIconButton(
          icon: Icons.message,
          height: 35.0,
          width: 35.0,
          function: () => CommonFunctions().makingSms(phoneNo: [phoneNo]),
        ),
      ],
    );
  }
}
