import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/profile_buttons.dart';
import 'package:bikes_user/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/widgets/others/profile_text_field.dart';
import 'package:bikes_user/widgets/painters/half_oval_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                    Container(
                      margin: const EdgeInsets.only(bottom: 4.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 4.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: CustomColors.kDarkGray
                                            .withOpacity(0.15)))),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: SvgPicture.asset(
                                    'assets/images/empty_star.svg',
                                    width: 10,
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 4.0),
                            child: Text(
                              '1000',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/crown.svg',
                            height: 10,
                            color: Colors.white,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: CustomColors.kOrange,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: CustomColors.kDarkGray.withOpacity(0.3),
                              // changes position of shadow
                              offset: Offset(0, 1.5),
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ProfileTextField(
                          isReadOnly: true,
                          initialValue: '034 866 9124',
                          labelText: CustomStrings.kPhoneNo),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: ProfileTextField(
                          isReadOnly: true,
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
                            child: SizedBox(
                              height: 35,
                              child: ElevatedButton.icon(
                                  onPressed: () => {
                                        Navigator.pushNamed(
                                            context, '/editProfile')
                                      },
                                  icon: Icon(
                                    Icons.two_wheeler,
                                    size: 22,
                                  ),
                                  label: Text(
                                    CustomStrings.kManageBike,
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
                            padding: const EdgeInsets.only(left: 4.0),
                            child: SizedBox(
                              height: 35,
                              child: ElevatedButton.icon(
                                  onPressed: () => {
                                        Navigator.pushNamed(
                                            context, '/editProfile')
                                      },
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
