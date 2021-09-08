import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String text;

  const TextContainer({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
          color: CustomColors.kLightGray,
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CustomColors.kDarkGray.withOpacity(0.3),
              // changes position of shadow
              offset: Offset(0, 1.5),
            )
          ]),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
