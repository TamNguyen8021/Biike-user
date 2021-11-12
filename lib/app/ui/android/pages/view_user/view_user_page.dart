import 'package:bikes_user/app/controllers/view_user_controller.dart';
import 'package:bikes_user/app/data/enums/gender_enum.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/history_trip_card.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/profile_text_field.dart';
import 'package:bikes_user/app/ui/android/widgets/others/user_rating.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// The 'view_user' page
class ViewUserPage extends StatelessWidget {
  const ViewUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewUserController = Get.find<ViewUserController>();
    Gender gender = Gender.male;

    final contactAndReportButtons = <Widget>[
      CustomElevatedIconButton(
        width: 115,
        onPressedFunc: () => CommonFunctions()
            .makingPhoneCall(phoneNo: _viewUserController.user.userPhoneNumber),
        text: CustomStrings.kCall.tr,
        elevation: 2.0,
        icon: Icons.phone,
        backgroundColor: CustomColors.kBlue,
        foregroundColor: Colors.white,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: CustomElevatedIconButton(
          width: 115,
          onPressedFunc: () => CommonFunctions()
              .makingSms(phoneNo: _viewUserController.user.userPhoneNumber),
          text: CustomStrings.kMessage.tr,
          elevation: 2.0,
          icon: Icons.message,
          backgroundColor: CustomColors.kBlue,
          foregroundColor: Colors.white,
        ),
      ),
      CustomElevatedIconButton(
        width: 115,
        onPressedFunc: () =>
            _viewUserController.showReportDialog(context: context),
        text: CustomStrings.kReport.tr,
        elevation: 2.0,
        icon: Icons.warning_amber,
        backgroundColor: CustomColors.kLightGray,
        foregroundColor: CustomColors.kDarkGray,
      ),
    ];

    return GetBuilder(
        init: _viewUserController,
        builder: (_) {
          return Scaffold(
              appBar: CustomAppBar(
                isVisible: true,
                hasShape: true,
                appBar: AppBar(),
                hasLeading: true,
                onPressedFunc: () {
                  Get.back();
                },
                title: Text(CustomStrings.kViewUser.tr),
              ),
              body: FutureBuilder(
                  future: _viewUserController.getPartnerProfile(
                      partnerId: Get.arguments['partnerId']),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SingleChildScrollView(
                        child: SafeArea(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 22.0),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            _viewUserController.user.avatar),
                                        radius: 55,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: UserRating(
                                          score: _viewUserController
                                              .user.userStar
                                              .toString()),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: Text(
                                          _viewUserController.user.userFullname,
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: CustomColors.kDarkGray,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          gender.getGenderText(
                                              _viewUserController.user.gender),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        if (_viewUserController
                                                .user.birthDate !=
                                            null) ...[
                                          Text(
                                            ' | ' +
                                                DateTime.tryParse(
                                                        _viewUserController
                                                            .user.birthDate!)!
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
                                        initialValue: _viewUserController
                                            .user.userPhoneNumber,
                                        labelText: CustomStrings.kPhoneNo.tr),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 30.0),
                                      child: ProfileTextField(
                                          isReadOnly: true,
                                          isEditProfile: false,
                                          // initialValue:
                                          //     _viewUserController.area.areaName,
                                          initialValue:
                                              CustomStrings.fptHCMUni.tr,
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    if (_viewUserController
                                        .historyTrips.isNotEmpty) ...[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: Text(
                                          CustomStrings.kHasHistoryTrip.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                    ],
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: RefreshIndicator(
                                        onRefresh: () => Future.sync(
                                          () => _viewUserController
                                              .pagingController
                                              .refresh(),
                                        ),
                                        child:
                                            PagedListView<int, HistoryTripCard>(
                                          pagingController: _viewUserController
                                              .pagingController,
                                          builderDelegate:
                                              PagedChildBuilderDelegate<
                                                      HistoryTripCard>(
                                                  itemBuilder: (context, item,
                                                          index) =>
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10.0),
                                                        child: HistoryTripCard(
                                                          tripId:
                                                              _viewUserController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .tripId,
                                                          userId:
                                                              _viewUserController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .userId,
                                                          dateTime:
                                                              _viewUserController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .dateTime,
                                                          status:
                                                              _viewUserController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .status,
                                                          sourceStation:
                                                              _viewUserController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .sourceStation,
                                                          destinationStation:
                                                              _viewUserController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .destinationStation,
                                                          isOnViewUserPage:
                                                              false,
                                                        ),
                                                      ),
                                                  noItemsFoundIndicatorBuilder:
                                                      (BuildContext context) {
                                                    return Text(CustomStrings
                                                        .kNoHistoryTrip.tr);
                                                  }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Loading();
                    }
                  }));
        });
  }
}
