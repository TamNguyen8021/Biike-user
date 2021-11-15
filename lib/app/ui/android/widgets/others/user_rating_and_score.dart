import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserRatingAndScore extends StatelessWidget {
  final double rating;
  final int score;

  const UserRatingAndScore(
      {Key? key, required this.rating, required this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 4.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(
                        color: CustomColors.kDarkGray.withOpacity(0.15)))),
            child: Row(
              children: <Widget>[
                Text(
                  rating.toString(),
                  style: TextStyle(fontSize: 11.sp, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: SvgPicture.asset(
                    'assets/images/empty_star.svg',
                    width: 10,
                    height: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(CommonRoutes.POINT),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 4.0),
                  child: Text(
                    score.toString(),
                    style: TextStyle(fontSize: 11.sp, color: Colors.white),
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/crown.svg',
                  height: 10,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
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
    );
  }
}
