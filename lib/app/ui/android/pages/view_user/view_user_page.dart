import 'package:bikes_user/app/controllers/view_user_controller.dart';
import 'package:bikes_user/app/data/enums/gender_enum.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/profile_text_field.dart';
import 'package:bikes_user/app/ui/android/widgets/others/user_rating.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_history_trips.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 'view_user' page
class ViewUserPage extends StatelessWidget {
  final userId;

  const ViewUserPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewUserController = Get.find<ViewUserController>();
    Gender gender = Gender.male;

    final contactAndReportButtons = <Widget>[
      CustomElevatedIconButton(
        width: 100,
        onPressedFunc: () => CommonFunctions()
            .makingPhoneCall(phoneNo: viewUserController.user.userPhoneNumber),
        text: CustomStrings.kCall.tr,
        elevation: 2.0,
        icon: Icons.phone,
        backgroundColor: CustomColors.kBlue,
        foregroundColor: Colors.white,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: CustomElevatedIconButton(
          width: 100,
          onPressedFunc: () => CommonFunctions()
              .makingSms(phoneNo: viewUserController.user.userPhoneNumber),
          text: CustomStrings.kMessage.tr,
          elevation: 2.0,
          icon: Icons.message,
          backgroundColor: CustomColors.kBlue,
          foregroundColor: Colors.white,
        ),
      ),
      CustomElevatedIconButton(
        width: 100,
        onPressedFunc: () =>
            viewUserController.showReportDialog(context: context),
        text: CustomStrings.kReport.tr,
        elevation: 2.0,
        icon: Icons.warning_amber,
        backgroundColor: CustomColors.kLightGray,
        foregroundColor: CustomColors.kDarkGray,
      ),
    ];

    return FutureBuilder(
        future: viewUserController.getPartnerProfile(
            context: context, partnerId: userId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // viewUserController.getUserHistoryTrips(context: context);
            return Scaffold(
              appBar: CustomAppBar(
                isVisible: true,
                hasShape: true,
                appBar: AppBar(),
                hasLeading: true,
                title: Text(CustomStrings.kViewUser.tr),
              ),
              body: snapshot.connectionState == ConnectionState.done
                  ? SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 22.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          viewUserController.user.avatar),
                                      radius: 55,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: UserRating(
                                        score: viewUserController.user.userStar
                                            .toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Text(
                                        viewUserController.user.userFullname,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: CustomColors.kDarkGray,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        gender.getGenderText(
                                            viewUserController.user.gender),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      if (DateTime.parse(viewUserController
                                                  .user.birthDate)
                                              .year !=
                                          DateTime.now().year) ...[
                                        Text(
                                          ' | ' +
                                              DateTime.parse(viewUserController
                                                      .user.birthDate)
                                                  .year
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ]
                                    ],
                                  ),
                                  ProfileTextField(
                                      isReadOnly: true,
                                      isEditProfile: false,
                                      initialValue: viewUserController
                                          .user.userPhoneNumber,
                                      labelText: CustomStrings.kPhoneNo.tr),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30.0),
                                    child: ProfileTextField(
                                        isReadOnly: true,
                                        isEditProfile: false,
                                        initialValue:
                                            viewUserController.area.areaName,
                                        labelText: CustomStrings.kSchool.tr),
                                  ),
                                  if (MediaQuery.of(context).size.width >=
                                      400) ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: contactAndReportButtons,
                                    ),
                                  ] else ...[
                                    Column(
                                      children: contactAndReportButtons,
                                    )
                                  ]
                                ],
                              ),
                            ),
                            Divider(),
                            FutureBuilder(
                                future: viewUserController
                                    .getHistoryTripsWithPartner(
                                        context: context,
                                        userId: Biike.userId,
                                        partnerId: userId),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22.0, vertical: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          if (viewUserController
                                              .historyTrips.isNotEmpty) ...[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16.0),
                                              child: Text(
                                                CustomStrings
                                                    .kHasHistoryTrip.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ],
                                          ListHistoryTrips(
                                              role: Role.none,
                                              listHistoryTrips:
                                                  viewUserController
                                                      .historyTrips
                                                      .toList(),
                                              itemPadding: 16.0),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Loading();
                                  }
                                }),
                          ],
                        ),
                      ),
                    )
                  : Loading(),
            );
          } else {
            return Loading();
          }
        });
  }
}
