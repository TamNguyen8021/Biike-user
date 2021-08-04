import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The home screen template for both ke-er and biker
class GetVoucherPage extends StatelessWidget {
  final String role;

  const GetVoucherPage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String modeButtonText = CustomStrings.kCustomerMode;
    String getVoucherText = 'Danh mục đổi quà';
    Color modeButtonForegroundColor = CustomColors.kBlue;
    Color modeButtonBackgroundColor = CustomColors.kLightGray;

    final String assetName = 'assets/images/king.svg';
    final Widget svgIcon = SvgPicture.asset(assetName,
        color: Colors.red, semanticsLabel: 'A red up arrow');

    List<String> vouchers = ['1', '2', '3', '4', '5'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(),
          leadingWidget: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text(
            getVoucherText,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                itemCount: vouchers.length,
                itemBuilder: (BuildContext context, int index) {
                  // Activity activity = destinations[index];
                  return Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                        height: 170.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(110.0, 20.0, 20.0, 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 120.0,
                                    child: Text(
                                      'Voucher 50% Toco Toco',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Áp dụng khi mua tại cửa hàng với hóa đơn từ 100k',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: <Widget>[
                                  Text('200',
                                  style: TextStyle(
                                    color: CustomColors.kOrange,
                                    fontWeight: FontWeight.bold,
                                  )),
                                  SizedBox(width: 4,),
                                  SvgPicture.asset(
                                    assetName,
                                    color: CustomColors.kOrange,
                                    height: 12,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20.0,
                        top: 15.0,
                        bottom: 15.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            width: 110.0,
                            image: AssetImage(
                              'assets/images/voucher-toco.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
