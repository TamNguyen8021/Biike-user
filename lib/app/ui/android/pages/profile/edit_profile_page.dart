import 'dart:io';

import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/others/profile_text_field.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// The 'update_profile' screen
class EditProfilePage extends StatelessWidget {
  final _profileController = Get.find<ProfileController>();

  Future<void> _onBackPressed() async {
    await _profileController.getProfile();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    Rx<bool> isSaveButtonDisable = _profileController
        .isSaveButtonDisable(
            newName: _profileController.user.userFullname,
            newGender: _profileController.user.gender,
            newBirthDate: _profileController.user.birthDate)
        .obs;
    Rx<String> birthDateText = CustomStrings.kChooseBirthDate.tr.obs;

    if (_profileController.birthDate.value != null) {
      birthDateText.value =
          DateFormat('dd-MM-yyyy').format(_profileController.birthDate.value!);
    }

    return OnBackPressed(
      perform: () {
        _onBackPressed();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          hasShape: true,
          hasLeading: true,
          onPressedFunc: () async {
            _onBackPressed();
          },
          appBar: AppBar(),
          title: Text(CustomStrings.kEditProfile.tr),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Obx(
                      () => CircleAvatar(
                        backgroundImage: _profileController.avatarUrl.value
                                .contains('http')
                            ? NetworkImage(_profileController.avatarUrl.value)
                            : FileImage(
                                    File(_profileController.avatarUrl.value))
                                as ImageProvider,
                        radius: 55,
                      ),
                    ),
                    Positioned(
                      top: 75,
                      left: 80,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: CustomColors.kBlue,
                        child: IconButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.image,
                            );

                            if (result != null) {
                              _profileController.avatarUrl.value =
                                  result.files.single.path!;
                              _profileController.avatarName =
                                  result.files.single.name;

                              isSaveButtonDisable.value =
                                  _profileController.isSaveButtonDisable(
                                      newName:
                                          _profileController.user.userFullname,
                                      newGender: _profileController.user.gender,
                                      newBirthDate:
                                          _profileController.user.birthDate);
                            } else {
                              // User canceled the picker
                            }
                          },
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
                      ProfileTextField(
                          isReadOnly: false,
                          isEditProfile: true,
                          initialValue: _profileController.user.userFullname,
                          labelText: CustomStrings.kFullName.tr,
                          onChangedFunc: (String name) {
                            _profileController.changeName(name);
                            isSaveButtonDisable.value =
                                _profileController.isSaveButtonDisable(
                                    newName:
                                        _profileController.user.userFullname,
                                    newGender: _profileController.user.gender,
                                    newBirthDate:
                                        _profileController.user.birthDate);
                          }),
                      ProfileTextField(
                          isReadOnly: true,
                          isEditProfile: true,
                          initialValue: _profileController.user.userPhoneNumber,
                          labelText: CustomStrings.kPhoneNo.tr),
                      ProfileTextField(
                        isReadOnly: true,
                        isEditProfile: true,
                        initialValue: _profileController.user.email,
                        labelText: CustomStrings.kEmail.tr,
                      ),
                      DropdownButtonFormField<int>(
                        value: _profileController.user.gender,
                        icon: Visibility(
                            visible: false, child: Icon(Icons.arrow_downward)),
                        decoration: InputDecoration(
                          labelText: CustomStrings.kGender.tr,
                          labelStyle: Theme.of(context).textTheme.headline6,
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
                          isSaveButtonDisable.value =
                              _profileController.isSaveButtonDisable(
                                  newName: _profileController.user.userFullname,
                                  newGender: _profileController.user.gender,
                                  newBirthDate:
                                      _profileController.user.birthDate);
                        },
                      ),
                      // Obx(
                      //   () => ChooseDateTimeButton(
                      //       isOnProfilePage: true,
                      //       text: birthDateText.value,
                      //       width: double.infinity,
                      //       onPressedFunc: () async {
                      //         DateTime _tempBirthDate = await CommonFunctions()
                      //             .selectDate(
                      //                 context: context,
                      //                 selectedDate:
                      //                     _profileController.birthDate,
                      //                 isBirthDatePicker: true);
                      //         _profileController.birthDate.value =
                      //             _tempBirthDate;
                      //         _profileController.user.birthDate =
                      //             _tempBirthDate.toString();
                      //         birthDateText.value = DateFormat('dd-MM-yyyy')
                      //             .format(_tempBirthDate);
                      //         isSaveButtonDisable.value =
                      //             _profileController.isSaveButtonDisable(
                      //                 newName:
                      //                     _profileController.user.userFullname,
                      //                 newGender: _profileController.user.gender,
                      //                 newBirthDate:
                      //                     _profileController.user.birthDate);
                      //       }),
                      // ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: CustomElevatedIconButton(
                            onPressedFunc: isSaveButtonDisable.isTrue
                                ? () {}
                                : () async {
                                    bool isSuccess =
                                        await _profileController.editProfile(
                                            context: context,
                                            user: _profileController.user);

                                    if (isSuccess) {
                                      isSaveButtonDisable.value = true;
                                    }
                                  },
                            text: CustomStrings.kSave.tr,
                            icon: Icons.save,
                            elevation: 0.0,
                            backgroundColor: isSaveButtonDisable.isTrue
                                ? CustomColors.kDarkGray
                                : CustomColors.kBlue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
