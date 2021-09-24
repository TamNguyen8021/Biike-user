import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/others/profile_text_field.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'update_profile' screen
class EditProfilePage extends StatelessWidget {
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        appBar: AppBar(),
        title: Text(CustomStrings.kEditProfile.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(_profileController.user.avatar),
                    radius: 55,
                  ),
                  Positioned(
                    top: 75,
                    left: 80,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: CustomColors.kBlue,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.camera_alt),
                        iconSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Form(
                  child: Column(
                children: <Widget>[
                  Obx(
                    () => ProfileTextField(
                        isReadOnly: false,
                        isEditProfile: true,
                        initialValue: '${_profileController.user.userFullname}',
                        labelText: CustomStrings.kFullName.tr),
                  ),
                  ProfileTextField(
                      isReadOnly: true,
                      isEditProfile: true,
                      initialValue: _profileController.user.userPhoneNumber,
                      labelText: CustomStrings.kPhoneNo.tr),
                  ProfileTextField(
                      isReadOnly: true,
                      isEditProfile: true,
                      initialValue: _profileController.user.userEmail,
                      labelText: CustomStrings.kEmail.tr),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Obx(
                      () => DropdownButtonFormField<int>(
                        value: _profileController.user.gender,
                        icon: Visibility(
                            visible: false, child: Icon(Icons.arrow_downward)),
                        decoration: InputDecoration(
                          labelText: CustomStrings.kGender.tr,
                          labelStyle: TextStyle(fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      CustomColors.kDarkGray.withOpacity(0.2))),
                        ),
                        items: <DropdownMenuItem<int>>[
                          DropdownMenuItem<int>(
                            child: Text(
                              CustomStrings.kMale.tr,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem<int>(
                            child: Text(
                              CustomStrings.kFemale.tr,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem<int>(
                            child: Text(
                              CustomStrings.kOthers.tr,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            value: 3,
                          ),
                        ],
                        onChanged: (int? gender) {
                          _profileController.changeGender(gender);
                        },
                      ),
                    ),
                  ),
                  CustomElevatedIconButton(
                    onPressedFunc: () => Get.back(),
                    text: CustomStrings.kSave.tr,
                    icon: Icons.save,
                    elevation: 0.0,
                    backgroundColor: CustomColors.kBlue,
                    foregroundColor: Colors.white,
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
