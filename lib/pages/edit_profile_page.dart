import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/others/profile_text_field.dart';
import 'package:flutter/material.dart';

/// The 'update_profile' screen
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    Gender? _gender = Gender.Male;

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
                    backgroundImage: AssetImage('assets/images/profile-1.jpg'),
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
                  ProfileTextField(
                      isReadOnly: false,
                      initialValue: 'Nguyễn Hoàng Thảo Vân',
                      labelText: CustomStrings.kFullName),
                  TextFormField(
                    initialValue: '034 866 9124',
                    readOnly: true,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.kDarkGray.withOpacity(0.5),
                        fontSize: 14),
                    decoration: InputDecoration(
                      labelText: CustomStrings.kPhoneNo,
                      labelStyle: Theme.of(context)
                          .inputDecorationTheme
                          .labelStyle!
                          .copyWith(
                              color: CustomColors.kDarkGray.withOpacity(0.5)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: CustomColors.kDarkGray.withOpacity(0.2))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: CustomColors.kDarkGray.withOpacity(0.2))),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: CustomColors.kDarkGray.withOpacity(0.2))),
                      focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: CustomColors.kDarkGray.withOpacity(0.2))),
                    ),
                  ),
                  ProfileTextField(
                      isReadOnly: false,
                      initialValue: 'phatdhse62854@fpt.edu.vn',
                      labelText: CustomStrings.kEmail),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: DropdownButtonFormField<Gender>(
                      value: _gender,
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
                          value: Gender.Male,
                        ),
                        DropdownMenuItem<Gender>(
                          child: Text(
                            CustomStrings.kFemale,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          value: Gender.Female,
                        ),
                        DropdownMenuItem<Gender>(
                          child: Text(
                            CustomStrings.kOthers,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          value: Gender.Other,
                        ),
                      ],
                      onChanged: (Gender? gender) {
                        setState(() {
                          _gender = gender;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: ElevatedButton.icon(
                        onPressed: () => {Navigator.pop(context)},
                        icon: Icon(
                          Icons.save,
                          size: 22,
                        ),
                        label: Text(
                          CustomStrings.kSave,
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(fontSize: 12),
                        ),
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style!
                            .copyWith(
                                elevation:
                                    MaterialStateProperty.all<double>(0.0))),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
