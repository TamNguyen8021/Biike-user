import 'package:bikes_user/pages/view_user/controller/view_user_controller.dart';
import 'package:bikes_user/utils/common_functions.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/widgets/lists/list_history_trips.dart';
import 'package:bikes_user/widgets/others/loading.dart';
import 'package:bikes_user/widgets/others/profile_text_field.dart';
import 'package:bikes_user/widgets/others/user_rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 'view_user' page
class ViewUserPage extends StatelessWidget {
  const ViewUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewUserController = Get.find<ViewUserController>();
    Gender gender = Gender.male;

    final contactAndReportButtons = <Widget>[
      CustomElevatedIconButton(
        onPressedFunc: () => CommonFunctions()
            .makingPhoneCall(phoneNo: viewUserController.user.userPhoneNumber),
        text: CustomStrings.kCall,
        elevation: 2.0,
        icon: Icons.phone,
        backgroundColor: CustomColors.kBlue,
        foregroundColor: Colors.white,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: CustomElevatedIconButton(
          onPressedFunc: () => CommonFunctions()
              .makingSms(phoneNo: viewUserController.user.userPhoneNumber),
          text: CustomStrings.kMessage,
          elevation: 2.0,
          icon: Icons.message,
          backgroundColor: CustomColors.kBlue,
          foregroundColor: Colors.white,
        ),
      ),
      CustomElevatedIconButton(
        onPressedFunc: () =>
            viewUserController.showReportDialog(context: context),
        text: CustomStrings.kReport,
        elevation: 2.0,
        icon: Icons.warning_amber,
        backgroundColor: CustomColors.kLightGray,
        foregroundColor: CustomColors.kDarkGray,
      ),
    ];

    return FutureBuilder(
        future: viewUserController.getUserInfo(context: context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // viewUserController.getUserHistoryTrips(context: context);
            return Scaffold(
              appBar: CustomAppBar(
                isVisible: true,
                hasShape: true,
                appBar: AppBar(),
                hasLeading: true,
                title: Text(CustomStrings.kViewUser),
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
                                            fontSize: 18,
                                            color: CustomColors.kDarkGray,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Text(
                                    gender.getGenderText(
                                        viewUserController.user.gender),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  ProfileTextField(
                                      isReadOnly: true,
                                      isEditProfile: false,
                                      initialValue: viewUserController
                                          .user.userPhoneNumber,
                                      labelText: CustomStrings.kPhoneNo),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30.0),
                                    child: ProfileTextField(
                                        isReadOnly: true,
                                        isEditProfile: false,
                                        initialValue:
                                            viewUserController.area.areaName,
                                        labelText: CustomStrings.kSchool),
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
                                future: viewUserController.getUserHistoryTrips(
                                    context: context),
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
                                                CustomStrings.kHasHistoryTrip,
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
