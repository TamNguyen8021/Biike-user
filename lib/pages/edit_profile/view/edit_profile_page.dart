import 'package:bikes_user/pages/edit_profile/controller/edit_profile_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/widgets/others/profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'update_profile' screen
class EditProfilePage extends StatelessWidget {
  final editProfileController = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        appBar: AppBar(),
        title: Text(CustomStrings.kEditProfile),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://ui-avatars.com/api/?name=Huu+Phat&background=random&rounded=true&size=128'),
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
                        initialValue: '${editProfileController.fullname}',
                        labelText: CustomStrings.kFullName),
                  ),
                  ProfileTextField(
                      isReadOnly: true,
                      isEditProfile: true,
                      initialValue: '034 866 9124',
                      labelText: CustomStrings.kPhoneNo),
                  ProfileTextField(
                      isReadOnly: true,
                      isEditProfile: true,
                      initialValue: 'vannthse123456@fpt.edu.vn',
                      labelText: CustomStrings.kEmail),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Obx(
                      () => DropdownButtonFormField<Gender>(
                        value: editProfileController.gender.value,
                        icon: Visibility(
                            visible: false, child: Icon(Icons.arrow_downward)),
                        decoration: InputDecoration(
                          labelText: CustomStrings.kGender,
                          labelStyle: TextStyle(fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      CustomColors.kDarkGray.withOpacity(0.2))),
                        ),
                        items: <DropdownMenuItem<Gender>>[
                          DropdownMenuItem<Gender>(
                            child: Text(
                              CustomStrings.kMale,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            value: Gender.male,
                          ),
                          DropdownMenuItem<Gender>(
                            child: Text(
                              CustomStrings.kFemale,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            value: Gender.female,
                          ),
                          DropdownMenuItem<Gender>(
                            child: Text(
                              CustomStrings.kOthers,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            value: Gender.other,
                          ),
                        ],
                        onChanged: (Gender? gender) {
                          editProfileController.changeGender(gender);
                        },
                      ),
                    ),
                  ),
                  CustomElevatedIconButton(
                    onPressedFunc: () => Get.back(),
                    text: CustomStrings.kSave,
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
