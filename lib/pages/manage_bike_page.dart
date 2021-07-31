import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/appbars/bottom_tabbar.dart';
import 'package:bikes_user/widgets/pages/activity.dart';
import 'package:bikes_user/widgets/pages/customer_home_full.dart';
import 'package:bikes_user/widgets/pages/driver_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The home screen template for both ke-er and biker
class ManageBikePage extends StatelessWidget {
  final String role;
  const ManageBikePage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String modeButtonText = CustomStrings.kCustomerMode;
    String manageBikeText = 'Quản lý xe';
    String settingButton = 'Cài đặt';
    String rateAppButton = 'Đánh giá ứng dụng';
    String logOutButton = 'Đăng xuất';
    String bikeNumberPlate = '75A - 456.15';
    String bikeOwner = 'Tên chủ xe';
    String bikeOwerValue = 'Đỗ Hữu Phát';
    String bikeCategory = 'Loại xe';
    String bikeCategoryValue = 'Tay ga';
    String bikeBrand = 'Hiệu xe';
    String bikeBrandValue = 'Yamaha';
    String bikeColor = 'Màu xe';
    String bikeColorValue = 'Tím';
    Color modeButtonForegroundColor = CustomColors.kBlue;
    Color modeButtonBackgroundColor = CustomColors.kLightGray;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(),
          leadingWidget: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text(
            manageBikeText,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.two_wheeler,
                                color: CustomColors.kBlue,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                bikeNumberPlate,
                                style: TextStyle(
                                    color: CustomColors.kDarkGray,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                        Divider(),
                        Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  bikeOwner,
                                  style: TextStyle(
                                      color: CustomColors.kDarkGray,
                                      fontSize: 12),
                                ),
                                Text(
                                  bikeOwerValue,
                                  style: TextStyle(
                                    color: CustomColors.kDarkGray,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  bikeCategory,
                                  style: TextStyle(
                                      color: CustomColors.kDarkGray,
                                      fontSize: 12),
                                ),
                                Text(
                                  bikeCategoryValue,
                                  style: TextStyle(
                                    color: CustomColors.kDarkGray,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  bikeBrand,
                                  style: TextStyle(
                                      color: CustomColors.kDarkGray,
                                      fontSize: 12),
                                ),
                                Text(
                                  bikeBrandValue,
                                  style: TextStyle(
                                    color: CustomColors.kDarkGray,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  bikeColor,
                                  style: TextStyle(
                                      color: CustomColors.kDarkGray,
                                      fontSize: 12),
                                ),
                                Text(
                                  bikeColorValue,
                                  style: TextStyle(
                                    color: CustomColors.kDarkGray,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: CustomColors.kLightGray,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: CustomColors.kDarkGray.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 0.5,
                            // changes position of shadow
                            offset: Offset(0, 0.5),
                          )
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
