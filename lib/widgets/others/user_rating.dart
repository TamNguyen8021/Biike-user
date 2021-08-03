import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserRating extends StatelessWidget {
  final String score;

  const UserRating({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: CustomColors.kOrange,
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CustomColors.kDarkGray.withOpacity(0.3),
              // changes position of shadow
              offset: Offset(0, 1.5),
            )
          ]),
      child: Text.rich(TextSpan(children: <InlineSpan>[
        TextSpan(
            text: score, style: TextStyle(fontSize: 11, color: Colors.white)),
        WidgetSpan(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
        )),
        WidgetSpan(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: SvgPicture.asset(
            'assets/images/empty_star.svg',
            width: 10,
            height: 10,
            color: Colors.white,
          ),
        ))
      ])),
    );
  }
}
