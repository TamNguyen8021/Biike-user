import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  final Function() onPressed;

  const CameraButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 50,
      child: IconButton(
          padding: const EdgeInsets.all(0.0),
          onPressed: onPressed,
          icon: Icon(
            Icons.camera_alt_outlined,
            color: CustomColors.kDarkGray,
          )),
      decoration: BoxDecoration(
        color: CustomColors.kLightGray,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
