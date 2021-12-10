import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget contains an sos number's details
class SOSNumberCard extends StatelessWidget {
  final int id;
  final String name;
  final String number;

  const SOSNumberCard(
      {Key? key, required this.id, required this.name, required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(CommonRoutes.EDIT_SOS_NUMBER, arguments: {
        'id': id,
        'name': name,
        'number': number,
      }),
      child: Container(
        height: 72,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(number, style: TextStyle(fontSize: 10.0)),
                  )
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 20,
              ),
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
