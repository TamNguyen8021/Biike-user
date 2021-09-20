import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// This widget contains an upcoming trip's details
class UpcomingTripCard extends StatelessWidget {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;
  final String avatarUrl;
  final String name;
  final String phoneNo;
  final String time;
  final String date;
  final int year;
  final String sourceStation;
  final String destinationStation;

  const UpcomingTripCard(
      {Key? key,
      this.backgroundColor,
      this.foregroundColor,
      this.iconColor,
      required this.avatarUrl,
      required this.name,
      required this.phoneNo,
      required this.time,
      required this.date,
      required this.year,
      required this.sourceStation,
      required this.destinationStation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(CommonRoutes.TRIP_DETAILS),
      child: Container(
        height: 82,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      if (name != CustomStrings.kFinding.tr) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(avatarUrl),
                          ),
                        ),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: SvgPicture.asset(
                            avatarUrl,
                            height: 50,
                          ),
                        ),
                      ],
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: foregroundColor != null
                                        ? foregroundColor
                                        : CustomColors.kDarkGray,
                                    fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              time,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: foregroundColor != null
                                          ? foregroundColor
                                          : CustomColors.kDarkGray),
                            ),
                          ),
                          Text(
                            date,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: foregroundColor != null
                                        ? foregroundColor
                                        : CustomColors.kDarkGray),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.adjust,
                          color: iconColor != null
                              ? iconColor
                              : CustomColors.kBlue,
                        ),
                      ),
                      Text(
                        sourceStation,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: foregroundColor != null
                                ? foregroundColor
                                : CustomColors.kDarkGray),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Icon(
                      Icons.more_vert_outlined,
                      color: iconColor != null ? iconColor : CustomColors.kBlue,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.location_on,
                          color: iconColor != null
                              ? iconColor
                              : CustomColors.kBlue,
                        ),
                      ),
                      Text(
                        destinationStation,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: foregroundColor != null
                                ? foregroundColor
                                : CustomColors.kDarkGray),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: backgroundColor != null
                ? backgroundColor
                : CustomColors.kLightGray,
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