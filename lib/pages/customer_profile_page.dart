import 'dart:ui';

import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/widgets/half_oval_bar.dart';
import 'package:bikes_user/widgets/others/user_rating.dart';
import 'package:flutter/material.dart';

/// The profile screen
class CustomerProfilePage extends StatelessWidget {
  final String role;

  const CustomerProfilePage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: false,
        appBar: AppBar(),
        leadingWidget: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        actionWidgets: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(right: 16.0, top: 19.0, bottom: 19.0),
              child: SwitchRoleButton(role: role))
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
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
                        'Đỗ Hữu Phát',
                        style: TextStyle(
                            fontSize: 18,
                            color: CustomColors.kBlue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: UserRating(score: '4.5'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: '034 866 9124',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.kDarkGray),
                        decoration:
                            InputDecoration(labelText: CustomStrings.kPhoneNo),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: 'phatdhse62856@fpt.edu.vn',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.kDarkGray),
                          decoration:
                              InputDecoration(labelText: CustomStrings.kEmail),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: SizedBox(
                        height: 35,
                        child: ElevatedButton.icon(
                            onPressed: () =>
                                {Navigator.pushNamed(context, '/editProfile')},
                            icon: Icon(
                              Icons.edit,
                              size: 22,
                            ),
                            label: Text(
                              CustomStrings.kEdit,
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
                                        MaterialStateProperty.all<double>(
                                            0.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () => {},
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.settings,
                                  color: CustomColors.kDarkGray,
                                  size: 20,
                                ),
                              ),
                              Text(
                                CustomStrings.kSettings,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColors.kLightGray),
                              elevation:
                                  MaterialStateProperty.all<double>(2.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () => {},
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.help,
                                  color: CustomColors.kDarkGray,
                                  size: 20,
                                ),
                              ),
                              Text(
                                CustomStrings.kHelp,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColors.kLightGray),
                              elevation:
                                  MaterialStateProperty.all<double>(2.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () => {},
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.star,
                                  color: CustomColors.kDarkGray,
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  CustomStrings.kRateApp,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  'v1.0.1',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColors.kLightGray),
                              elevation:
                                  MaterialStateProperty.all<double>(2.0)),
                        ),
                      ),
                    ),
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
