import 'package:bikes_user/pages/view_user/controller/view_user_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/widgets/others/loading.dart';
import 'package:bikes_user/widgets/others/profile_text_field.dart';
import 'package:bikes_user/widgets/others/user_rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewUserPage extends StatelessWidget {
  const ViewUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewUserController = Get.find<ViewUserController>();
    Gender gender = Gender.Male;

    return FutureBuilder(
        future: viewUserController.getUserInfo(context: context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                                  padding: const EdgeInsets.only(bottom: 10.0),
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
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                ProfileTextField(
                                    isReadOnly: true,
                                    isEditProfile: false,
                                    initialValue:
                                        viewUserController.user.userPhoneNumber,
                                    labelText: CustomStrings.kPhoneNo),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: ProfileTextField(
                                      isReadOnly: true,
                                      isEditProfile: false,
                                      initialValue: 'Đại học FPT TP.HCM',
                                      labelText: CustomStrings.kSchool),
                                ),
                                if (MediaQuery.of(context).size.width >=
                                    400) ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6.0),
                                        child: CustomElevatedIconButton(
                                          onPressedFunc: () {},
                                          text: CustomStrings.kCall,
                                          elevation: 2.0,
                                          icon: Icons.phone,
                                          backgroundColor: CustomColors.kBlue,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6.0, right: 12.0),
                                        child: CustomElevatedIconButton(
                                          onPressedFunc: () {},
                                          text: CustomStrings.kMessage,
                                          elevation: 2.0,
                                          icon: Icons.message,
                                          backgroundColor: CustomColors.kBlue,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                      CustomElevatedIconButton(
                                        onPressedFunc: () {},
                                        text: CustomStrings.kReport,
                                        elevation: 2.0,
                                        icon: Icons.warning_amber,
                                        backgroundColor:
                                            CustomColors.kLightGray,
                                        foregroundColor: CustomColors.kDarkGray,
                                      ),
                                    ],
                                  ),
                                ] else ...[
                                  Column(
                                    children: <Widget>[
                                      CustomElevatedIconButton(
                                        onPressedFunc: () {},
                                        text: CustomStrings.kCall,
                                        elevation: 2.0,
                                        icon: Icons.phone,
                                        backgroundColor: CustomColors.kBlue,
                                        foregroundColor: Colors.white,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: CustomElevatedIconButton(
                                          onPressedFunc: () {},
                                          text: CustomStrings.kMessage,
                                          elevation: 2.0,
                                          icon: Icons.message,
                                          backgroundColor: CustomColors.kBlue,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                      CustomElevatedIconButton(
                                        onPressedFunc: () {},
                                        text: CustomStrings.kReport,
                                        elevation: 2.0,
                                        icon: Icons.warning_amber,
                                        backgroundColor:
                                            CustomColors.kLightGray,
                                        foregroundColor: CustomColors.kDarkGray,
                                      ),
                                    ],
                                  )
                                ]
                              ],
                            ),
                          ),
                          Divider(),
                          Text(
                            CustomStrings.kNoHistoryTrip,
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                    ),
                  )
                : Loading(),
          );
        });
  }
}
