import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class HelpCenterRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isLastRow;

  const HelpCenterRow(
      {Key? key,
      required this.icon,
      required this.text,
      required this.isLastRow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    icon,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: isLastRow ? false : true,
            child: Divider(
              color: CustomColors.kDarkGray,
            ),
          ),
        ],
      ),
    );
  }
}
