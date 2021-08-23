import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/profile_buttons.dart';
import 'package:bikes_user/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/widgets/others/profile_text_field.dart';
import 'package:bikes_user/widgets/painters/half_oval_painter.dart';
import 'package:bikes_user/widgets/others/user_rating.dart';
import 'package:flutter/material.dart';

/// The customer profile screen
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
        hasLeading: true,
        role: 'Customer',
        actionWidgets: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(right: 16.0, top: 19.0, bottom: 19.0),
              child: SwitchRoleButton(
                role: role,
                route: '/driverProfile',
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: UserRating(score: '4.5'),
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
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton.icon(
                              onPressed: () => {
                                    Navigator.pushNamed(context, '/editProfile')
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
      ),
    );
  }
}
