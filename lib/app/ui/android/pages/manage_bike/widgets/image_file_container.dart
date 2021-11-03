import 'dart:io';

import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class ImageFileContainer extends StatelessWidget {
  final bool condition;
  final String path;

  const ImageFileContainer(
      {Key? key, required this.condition, required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
      child: condition
          ? Container(
              height: 250,
              decoration: BoxDecoration(
                color: CustomColors.kLightGray,
                borderRadius: BorderRadius.circular(5),
              ),
            )
          : Container(
              height: 250,
              child: Image.file(File(path), fit: BoxFit.cover),
            ),
    );
  }
}
