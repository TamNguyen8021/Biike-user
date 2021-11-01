import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget contains an ban's details
class BanListCard extends StatelessWidget {
  final String name;

  const BanListCard({
    Key? key,
    required this.name,
    required this.onTapUnBlock,
  }) : super(key: key);
  final Function onTapUnBlock;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapUnBlock(),
      child: Container(
        height: 42,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: CustomColors.kDarkGray,
                  )),
              Text(CustomStrings.kUnBlock.tr,
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontSize: 14.0, color: CustomColors.kDarkBlue)),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: CustomColors.kLightGray,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: CustomColors.kDarkGray.withOpacity(0.5),
                // changes position of shadow
                offset: Offset(0, 1),
              )
            ]),
      ),
    );
  }
}
