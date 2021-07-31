import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/half_oval_bar.dart';
import 'package:bikes_user/widgets/others/user_rating.dart';
import 'package:flutter/material.dart';

/// The profile screen
class ProfilePage extends StatelessWidget {
  final String role;

  const ProfilePage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _route = '/driverHome';
    if (role != 'Customer') {
      _route = '/customerHome';
    }

    String _modeButtonText = CustomStrings.kCustomerMode;
    Color _modeButtonForegroundColor = CustomColors.kBlue;
    Color _modeButtonBackgroundColor = CustomColors.kLightGray;

    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        appBar: AppBar(),
        leadingWidget: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        actionWidgets: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              height: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, _route);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Text(
                    _modeButtonText,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: _modeButtonForegroundColor),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        _modeButtonBackgroundColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)))),
              ),
            ),
          )
        ],
        // bottomAppBar: PreferredSize(
        //   preferredSize:
        //       Size.fromHeight(new AppBar().preferredSize.height - 40.0),
        //   child: CustomPaint(
        //     painter: HalfOvalPainter(),
        //     child: Container(height: 100),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile-1.jpg'),
                    radius: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Đỗ Hữu Phát',
                    style: TextStyle(
                        fontSize: 18,
                        color: CustomColors.kBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: UserRating(score: '4.5'),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          readOnly: true,
                          initialValue: '034 866 9124',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.kDarkGray),
                          decoration: InputDecoration(
                              labelText: CustomStrings.kPhoneNo,
                              labelStyle: TextStyle(fontSize: 10)),
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: 'phatdhse62856@fpt.edu.vn',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.kDarkGray),
                          decoration: InputDecoration(
                              labelText: CustomStrings.kEmail,
                              labelStyle: TextStyle(fontSize: 10)),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    height: 35,
                    child: ElevatedButton.icon(
                      onPressed: () => {},
                      icon: Icon(Icons.edit),
                      label: Text(
                        CustomStrings.kEdit,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.kBlue),
                          elevation: MaterialStateProperty.all<double>(0.0)),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 35,
                        child: ElevatedButton.icon(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.settings,
                            color: CustomColors.kDarkGray,
                          ),
                          label: Text(
                            CustomStrings.kSettings,
                            style: TextStyle(
                                color: CustomColors.kDarkGray,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColors.kLightGray),
                              elevation:
                                  MaterialStateProperty.all<double>(0.0)),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: ElevatedButton.icon(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.help,
                            color: CustomColors.kDarkGray,
                          ),
                          label: Text(
                            CustomStrings.kHelp,
                            style: TextStyle(
                                color: CustomColors.kDarkGray,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColors.kLightGray),
                              elevation:
                                  MaterialStateProperty.all<double>(0.0)),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: ElevatedButton.icon(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.star,
                            color: CustomColors.kDarkGray,
                          ),
                          label: Text(
                            CustomStrings.kRateApp,
                            style: TextStyle(
                                color: CustomColors.kDarkGray,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColors.kLightGray),
                              elevation:
                                  MaterialStateProperty.all<double>(0.0)),
                        ),
                      ),
                      Text(CustomStrings.kLogOut),
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
