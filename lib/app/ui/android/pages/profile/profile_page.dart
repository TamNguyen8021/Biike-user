import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/profile_text_field.dart';
import 'package:bikes_user/app/ui/android/widgets/others/user_rating_and_score.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/profile_buttons.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/app/ui/android/widgets/painters/half_oval_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 'profile' screen
class ProfilePage extends StatelessWidget {
  final _profileController = Get.find<ProfileController>();
  final _walletController = Get.find<WalletController>();

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hasShape: false,
        appBar: AppBar(),
        hasLeading: true,
        onPressedFunc: () {
          Get.offAllNamed(CommonRoutes.HOME);
        },
        actionWidgets: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0, top: 19.0, bottom: 19.0),
            child: SwitchRoleButton(
              route: CommonRoutes.PROFILE,
              isOnProfilePage: true,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _profileController.getProfile(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FutureBuilder(
                  future: _walletController.updateWalletPoint(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SingleChildScrollView(
                        child: SafeArea(
                          child: GetBuilder<ProfileController>(
                              init: _profileController,
                              builder: (ProfileController controller) {
                                return Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Stack(
                                        children: <Widget>[
                                          CustomPaint(
                                            painter: HalfOvalPainter(),
                                            child: Container(height: 50),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  controller.user.avatar),
                                              radius: 50,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22.0),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 6.0),
                                            child: Text(
                                              controller.user.userFullname,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                          ),
                                          Obx(
                                            () => UserRatingAndScore(
                                                rating:
                                                    controller.user.userStar,
                                                score: _walletController
                                                    .totalWalletPoint.value),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: ProfileTextField(
                                                isReadOnly: true,
                                                isEditProfile: false,
                                                initialValue: controller
                                                    .user.userPhoneNumber,
                                                labelText:
                                                    CustomStrings.kPhoneNo.tr),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 25.0),
                                            child: ProfileTextField(
                                                isReadOnly: true,
                                                isEditProfile: false,
                                                initialValue:
                                                    controller.user.email,
                                                labelText:
                                                    CustomStrings.kEmail.tr),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                if (Biike.role.value ==
                                                    Role.biker) ...[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child:
                                                        CustomElevatedIconButton(
                                                      width: 135,
                                                      onPressedFunc: () =>
                                                          Get.toNamed(
                                                              CommonRoutes
                                                                  .MANAGE_BIKE),
                                                      text: CustomStrings
                                                          .kManageBike.tr,
                                                      elevation: 0.0,
                                                      icon: Icons.two_wheeler,
                                                      backgroundColor:
                                                          CustomColors.kBlue,
                                                      foregroundColor:
                                                          Colors.white,
                                                    ),
                                                  ),
                                                ],
                                                CustomElevatedIconButton(
                                                  width: 135,
                                                  onPressedFunc: () =>
                                                      Get.toNamed(CommonRoutes
                                                          .EDIT_PROFILE),
                                                  text: CustomStrings.kEdit.tr,
                                                  icon: Icons.edit,
                                                  elevation: 0.0,
                                                  backgroundColor:
                                                      CustomColors.kBlue,
                                                  foregroundColor: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                          ProfileButtons(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 24.0),
                                            child: TextButton(
                                              child: Text(
                                                CustomStrings.kLogOut.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                              onPressed: () {
                                                LocalAppData().logout();
                                                Get.offAllNamed(
                                                    CommonRoutes.LOGIN);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      );
                    } else {
                      return Loading();
                    }
                  });
            } else {
              return Loading();
            }
          }),
    );
  }
}
