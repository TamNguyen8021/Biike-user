import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/widgets/half_oval_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        leadingWidget: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/driverHome');
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
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
      body: SafeArea(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
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
                            style: TextStyle(fontSize: 11, color: Colors.white),
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
                      padding: const EdgeInsets.only(bottom: 20.0),
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
                            elevation: MaterialStateProperty.all<double>(2.0)),
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
                            elevation: MaterialStateProperty.all<double>(2.0)),
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
                            elevation: MaterialStateProperty.all<double>(2.0)),
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
    );
  }
}
