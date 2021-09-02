import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/widgets/buttons/profile_buttons.dart';
import 'package:bikes_user/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/widgets/others/profile_text_field.dart';
import 'package:bikes_user/widgets/others/user_rating_and_score.dart';
import 'package:bikes_user/widgets/painters/half_oval_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The driver profile screen
class DriverProfilePage extends StatelessWidget {
  final String role;

  const DriverProfilePage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: false,
        appBar: AppBar(),
        hasLeading: true,
        role: 'Driver',
        actionWidgets: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(right: 16.0, top: 19.0, bottom: 19.0),
              child: SwitchRoleButton(
                role: role,
                route: '/customerProfile',
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Stack(
                  children: <Widget>[
                    CustomPaint(
                      painter: HalfOvalPainter(),
                      child: Container(height: 50),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profile-1.jpg'),
                        radius: 50,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Phát Đỗ',
                        style: TextStyle(
                            fontSize: 18,
                            color: CustomColors.kBlue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    UserRatingAndScore(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ProfileTextField(
                          isReadOnly: true,
                          isEditProfile: false,
                          initialValue: '034 866 9124',
                          labelText: CustomStrings.kPhoneNo),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: ProfileTextField(
                          isReadOnly: true,
                          isEditProfile: false,
                          initialValue: 'phatdhse62856@fpt.edu.vn',
                          labelText: CustomStrings.kEmail),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: CustomElevatedIconButton(
                              onPressedFunc: () => Get.toNamed('/manageBike'),
                              text: CustomStrings.kManageBike,
                              elevation: 0.0,
                              icon: Icons.two_wheeler,
                              backgroundColor: CustomColors.kBlue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: CustomElevatedIconButton(
                              onPressedFunc: () => Get.toNamed('/editProfile'),
                              text: CustomStrings.kEdit,
                              icon: Icons.edit,
                              elevation: 0.0,
                              backgroundColor: CustomColors.kBlue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ProfileButtons(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: TextButton(
                        child: Text(
                          CustomStrings.kLogOut,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
