import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class ChooseDateTimeButton extends StatelessWidget {
  final String text;
  final double? width;
  final Function() onPressedFunc;
  final bool isOnProfilePage;

  const ChooseDateTimeButton(
      {Key? key,
      required this.text,
      this.width,
      required this.onPressedFunc,
      required this.isOnProfilePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width == null
            ? MediaQuery.of(context).size.width / 2 - 54.0
            : width,
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: CustomColors.kDarkGray.withOpacity(0.2))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isOnProfilePage) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(CustomStrings.kBirthDate.tr,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: CustomColors.kDarkGray)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ] else ...[
              ElevatedButton(
                onPressed: onPressedFunc,
                style: ElevatedButton.styleFrom(
                  primary: CustomColors.kLightGray,
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ]
          ],
        ),
      ),
      onTap: isOnProfilePage ? onPressedFunc : null,
    );
  }
}
