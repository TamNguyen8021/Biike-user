import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';

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
                  TextFormField(
                    initialValue: 'Đỗ Hữu Phát',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.kDarkGray),
                    decoration:
                        InputDecoration(labelText: CustomStrings.kFullName),
                  ),
                  DropdownButtonFormField<Gender>(
                    value: _gender,
                    decoration:
                        InputDecoration(labelText: CustomStrings.kGender),
                    items: const <DropdownMenuItem<Gender>>[
                      DropdownMenuItem<Gender>(
                        child: Text(
                          CustomStrings.kMale,
                          style: TextStyle(
                              color: CustomColors.kDarkGray,
                              fontWeight: FontWeight.bold),
                        ),
                        value: Gender.Male,
                      ),
                      DropdownMenuItem<Gender>(
                        child: Text(CustomStrings.kFemale,
                            style: TextStyle(
                                color: CustomColors.kDarkGray,
                                fontWeight: FontWeight.bold)),
                        value: Gender.Female,
                      ),
                      DropdownMenuItem<Gender>(
                        child: Text(CustomStrings.kOthers,
                            style: TextStyle(
                                color: CustomColors.kDarkGray,
                                fontWeight: FontWeight.bold)),
                        value: Gender.Other,
                      ),
                    ],
                    onChanged: (Gender? gender) {
                      setState(() {
                        _gender = gender;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: '034 866 9124',
                    readOnly: true,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.kDarkGray.withOpacity(0.5)),
                    decoration: InputDecoration(
                        labelText: CustomStrings.kPhoneNo,
                        labelStyle: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle!
                            .copyWith(
                                color:
                                    CustomColors.kDarkGray.withOpacity(0.5))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      initialValue: 'phatdhse64000@fpt.edu.vn',
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.kDarkGray),
                      decoration:
                          InputDecoration(labelText: CustomStrings.kEmail),
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
