import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/appbars/bottom_tabbar.dart';
import 'package:bikes_user/widgets/pages/activity.dart';
import 'package:bikes_user/widgets/pages/customer_home_full.dart';
import 'package:bikes_user/widgets/pages/driver_home.dart';
import 'package:flutter/material.dart';

/// The home screen template for both ke-er and biker
class ProfilePage extends StatelessWidget {
  final String role;
  const ProfilePage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String modeButtonText = CustomStrings.kCustomerMode;
    String editButton = 'Chỉnh sửa';
    String settingButton = 'Cài đặt';
    String rateAppButton = 'Đánh giá ứng dụng';
    String logOutButton = 'Đăng xuất';
    Color modeButtonForegroundColor = CustomColors.kBlue;
    Color modeButtonBackgroundColor = CustomColors.kLightGray;

    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        actionWidgets: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              height: 10,
              child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Text(
                    modeButtonText,
                    style: TextStyle(
                        color: modeButtonForegroundColor, fontSize: 10),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        modeButtonBackgroundColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)))),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(

                        backgroundImage:
                            AssetImage('assets/images/profile-1.jpg'),
                      ),
                      Text('Đỗ Hữu Phát'),
                      ElevatedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: Text(
                            '4.5',
                            style: TextStyle(
                                color: modeButtonForegroundColor, fontSize: 10),
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                modeButtonBackgroundColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Số điện thoai'),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '034 866 9124'),
                      ),

                      Text('Email'),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'phatdhse62856@fpt.edu.vn'),
                      ),

                    ],
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: 35,
                  child: ElevatedButton.icon(
                    onPressed: () => {},
                    icon: Icon(Icons.edit),
                    label: Text(
                      editButton,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(CustomColors.kBlue),
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
                            settingButton,
                            style: TextStyle(
                                color: CustomColors.kDarkGray, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                              elevation: MaterialStateProperty.all<double>(0.0)),
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
                                color: CustomColors.kDarkGray, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                              elevation: MaterialStateProperty.all<double>(0.0)),
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
                                color: CustomColors.kDarkGray, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                              elevation: MaterialStateProperty.all<double>(0.0)),
                        ),
                      ),

                      Text(logOutButton),

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
