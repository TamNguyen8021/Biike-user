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
        appBar: AppBar(),
        title: Text(CustomStrings.kEditProfile),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile-1.jpg'),
                radius: 50,
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
                  TextFormField(
                    initialValue: '034 866 9124',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.kDarkGray),
                    decoration:
                        InputDecoration(labelText: CustomStrings.kPhoneNo),
                  ),
                  TextFormField(
                    initialValue: 'phatdhse64000@fpt.edu.vn',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.kDarkGray),
                    decoration:
                        InputDecoration(labelText: CustomStrings.kEmail),
                  ),
                  DropdownButtonFormField<Gender>(
                    value: _gender,
                    decoration:
                        InputDecoration(labelText: CustomStrings.kGender),
                    items: const <DropdownMenuItem<Gender>>[
                      DropdownMenuItem<Gender>(
                        child: Text(CustomStrings.kMale),
                        value: Gender.Male,
                      ),
                      DropdownMenuItem<Gender>(
                        child: Text(CustomStrings.kFemale),
                        value: Gender.Female,
                      ),
                      DropdownMenuItem<Gender>(
                        child: Text(CustomStrings.kOthers),
                        value: Gender.Other,
                      ),
                    ],
                    onChanged: (Gender? gender) {
                      setState(() {
                        _gender = gender;
                      });
                    },
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
