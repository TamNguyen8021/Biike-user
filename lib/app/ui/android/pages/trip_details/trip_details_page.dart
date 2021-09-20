import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/confirm_arrival_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/map_viewer.dart';
import 'package:bikes_user/app/ui/android/widgets/others/user_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// 'trip_details' screen
class TripDetailsPage extends StatelessWidget {
  final tripDetailsController = Get.find<TripDetailsController>();

  /// Only used for ke-er
  final bool isWaitingForBiker;

  TripDetailsPage({
    Key? key,
    required this.isWaitingForBiker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        appBar: AppBar(),
        title: Text(CustomStrings.kTripDetails.tr),
        actionWidgets: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.support,
                color: CustomColors.kBlue,
              ),
              label: Text(
                CustomStrings.kSupport.tr,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: CustomColors.kBlue),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: CustomColors.kDarkGray.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      isWaitingForBiker
                          ? CustomStrings.kNewTrip.tr
                          : CustomStrings.kTripHasBiker.tr,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '05:07, 08 Tháng 3, 2021',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              MapViewer(),
              IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            right: BorderSide(
                                color:
                                    CustomColors.kDarkGray.withOpacity(0.1))),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              margin: const EdgeInsets.only(bottom: 5.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        CustomColors.kDarkGray.withOpacity(0.1),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.event_outlined,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      '08/03/2021',
                                      style: TextStyle(
                                          color: CustomColors.kDarkGray),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    Icons.access_time,
                                  ),
                                ),
                                Text(
                                  '06:35',
                                  style:
                                      TextStyle(color: CustomColors.kDarkGray),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.adjust,
                                    ),
                                  ),
                                  Text(
                                    'Chung cư SKY9',
                                    style: TextStyle(
                                        color: CustomColors.kDarkGray),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.more_vert_outlined,
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.location_on,
                                    ),
                                  ),
                                  Text(
                                    'Đại học FPT TP.HCM',
                                    style: TextStyle(
                                        color: CustomColors.kDarkGray),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                    color: CustomColors.kLightGray,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: <Widget>[
                    if (!isWaitingForBiker) ...[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                              'https://ui-avatars.com/api/?name=Huu+Phat&background=random&rounded=true&size=128'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5.0, top: 10.0),
                              child: Text(
                                'Yến Linh',
                                style: TextStyle(
                                    color: CustomColors.kBlue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            UserRating(score: '4.5'),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: ContactButtons(
                                phoneNo: '',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SvgPicture.asset(
                          'assets/images/loading.svg',
                        ),
                      ),
                      Text(
                        CustomStrings.kFinding.tr,
                        style: TextStyle(
                          color: CustomColors.kBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Center(
                        child: SizedBox(
                          width: isWaitingForBiker ? 152 : double.infinity,
                          child: CustomElevatedIconButton(
                            onPressedFunc: () {},
                            text: CustomStrings.kCancelTrip.tr,
                            backgroundColor: CustomColors.kLightGray,
                            foregroundColor: CustomColors.kDarkGray,
                            elevation: 0.0,
                            icon: Icons.clear,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!isWaitingForBiker) ...[
                    if (Biike.role.value == Role.biker) ...[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Obx(
                            () => CustomElevatedIconButton(
                              onPressedFunc: () => tripDetailsController
                                  .changeToFinishTripButton(),
                              text: '${tripDetailsController.buttonText}',
                              backgroundColor: CustomColors.kBlue,
                              foregroundColor: Colors.white,
                              elevation: 0.0,
                              icon: tripDetailsController.buttonIcon.value,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: ConfirmArrivalButton(
                          isOnHomeScreen: false,
                        ),
                      ),
                    ]
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
