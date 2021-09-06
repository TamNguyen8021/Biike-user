import 'package:bikes_user/widgets/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';

/// This widget includes two buttons: call and message
class ContactButtons extends StatelessWidget {
  const ContactButtons({Key? key}) : super(key: key);

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
            function: () {},
          ),
        ),
        CustomIconButton(
          icon: Icons.message,
          height: 35.0,
          width: 35.0,
          function: () {},
        ),
      ],
    );
  }
}
