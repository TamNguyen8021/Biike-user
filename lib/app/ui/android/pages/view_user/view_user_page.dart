import 'package:bikes_user/app/controllers/view_user_controller.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/history_trip_card.dart';
import 'package:bikes_user/app/ui/android/widgets/others/LazyLoadingListErrorBuilder.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
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
              .makingSms(phoneNo: [_viewUserController.user.userPhoneNumber]),
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
      Obx(
        () => Visibility(
          visible: !_viewUserController.isUserBlocked.value,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CustomElevatedIconButton(
                width: 115,
                backgroundColor: CustomColors.kRed,
                foregroundColor: Colors.white,
                text: CustomStrings.kBlock.tr,
                elevation: 2.0,
                icon: Icons.remove_circle,
                onPressedFunc: () {
                  _viewUserController.showConfirmBlockDialog(context: context);
                }),
          ),
        ),
      ),
    ];

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
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      _viewUserController.user.avatar),
                                  radius: 55,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: UserRating(
                                    score: _viewUserController.user.userStar
                                        .toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                    _viewUserController.user.userFullname,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: CustomColors.kDarkGray,
                                        fontWeight: FontWeight.bold)),
                              ),
                              if (MediaQuery.of(context).size.width >= 400) ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                        GetBuilder<ViewUserController>(
                            init: _viewUserController,
                            builder: (ViewUserController controller) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    if (controller.historyTrips.isNotEmpty) ...[
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
                                    RefreshIndicator(
                                      onRefresh: () => Future.sync(
                                        () => controller.pagingController
                                            .refresh(),
                                      ),
                                      child:
                                          PagedListView<int, HistoryTripCard>(
                                        pagingController:
                                            controller.pagingController,
                                        shrinkWrap: true,
                                        builderDelegate:
                                            PagedChildBuilderDelegate<
                                                    HistoryTripCard>(
                                                animateTransitions: true,
                                                itemBuilder: (context, item,
                                                        index) =>
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10.0),
                                                      child: HistoryTripCard(
                                                        tripId: controller
                                                            .pagingController
                                                            .itemList!
                                                            .elementAt(index)
                                                            .tripId,
                                                        userId: controller
                                                            .pagingController
                                                            .itemList!
                                                            .elementAt(index)
                                                            .userId,
                                                        dateTime: controller
                                                            .pagingController
                                                            .itemList!
                                                            .elementAt(index)
                                                            .dateTime,
                                                        status: controller
                                                            .pagingController
                                                            .itemList!
                                                            .elementAt(index)
                                                            .status,
                                                        sourceStation: controller
                                                            .pagingController
                                                            .itemList!
                                                            .elementAt(index)
                                                            .sourceStation,
                                                        destinationStation:
                                                            controller
                                                                .pagingController
                                                                .itemList!
                                                                .elementAt(
                                                                    index)
                                                                .destinationStation,
                                                        isOnViewUserPage: true,
                                                      ),
                                                    ),
                                                noItemsFoundIndicatorBuilder:
                                                    (BuildContext context) {
                                                  return Text(
                                                    CustomStrings
                                                        .kNoHistoryTrip.tr,
                                                    textAlign: TextAlign.center,
                                                  );
                                                },
                                                firstPageErrorIndicatorBuilder:
                                                    (BuildContext context) {
                                                  return LazyLoadingListErrorBuilder(
                                                      onPressed: () {
                                                    controller.pagingController
                                                        .refresh();
                                                  });
                                                }),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                );
              } else {
                return Loading();
              }
            }));
  }
}
