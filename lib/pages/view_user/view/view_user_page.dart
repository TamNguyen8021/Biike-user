import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/custom_elevated_button.dart';
import 'package:bikes_user/widgets/others/profile_text_field.dart';
import 'package:bikes_user/widgets/others/user_rating.dart';
import 'package:flutter/material.dart';

class ViewUserPage extends StatelessWidget {
  const ViewUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        appBar: AppBar(),
        hasLeading: true,
        title: Text(CustomStrings.kViewUser),
      ),
      body: SingleChildScrollView(
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
                        backgroundImage:
                            AssetImage('assets/images/profile-1.jpg'),
                        radius: 55,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: UserRating(score: '4.5'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text('Phát Đỗ',
                          style: TextStyle(
                              fontSize: 18,
                              color: CustomColors.kDarkGray,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      'Nam',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    ProfileTextField(
                        isReadOnly: true,
                        initialValue: '034 866 9124',
                        labelText: CustomStrings.kPhoneNo),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: ProfileTextField(
                          isReadOnly: true,
                          initialValue: 'Đại học FPT TP.HCM',
                          labelText: CustomStrings.kSchool),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: CustomElevatedButton(
                            onPressedFunc: () {},
                            text: CustomStrings.kCall,
                            elevation: 2.0,
                            icon: Icons.phone,
                            backgroundColor: CustomColors.kBlue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 6.0, right: 12.0),
                          child: CustomElevatedButton(
                            onPressedFunc: () {},
                            text: CustomStrings.kMessage,
                            elevation: 2.0,
                            icon: Icons.message,
                            backgroundColor: CustomColors.kBlue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        CustomElevatedButton(
                          onPressedFunc: () {},
                          text: CustomStrings.kReport,
                          elevation: 2.0,
                          icon: Icons.warning_amber,
                          backgroundColor: CustomColors.kLightGray,
                          foregroundColor: CustomColors.kDarkGray,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: CustomColors.kDarkGray.withOpacity(0.5),
              ),
              Text(
                CustomStrings.kNoHistoryTrip,
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
