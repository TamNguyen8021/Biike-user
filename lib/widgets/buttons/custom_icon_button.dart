import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final double? height;
  final double? width;
  final IconData icon;
  final void Function()? function;

  const CustomIconButton(
      {Key? key, this.height, this.width, required this.icon, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: CustomColors.kBlue,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CustomColors.kDarkGray.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              // changes position of shadow
              offset: Offset(0, 0.5),
            )
          ]),
      child: IconButton(
        onPressed: function,
        icon: Icon(icon),
        color: Colors.white,
        iconSize: 20,
      ),
    );
  }
}
