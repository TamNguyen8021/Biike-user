import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/lists/list_vouchers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverPointPage extends StatelessWidget {
  const DriverPointPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        appBar: AppBar(),
        title: Text(CustomStrings.kListVouchers),
        actionWidgets: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 17.0, horizontal: 22.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
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
              child: Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: '1000',
                    style: TextStyle(fontSize: 11, color: Colors.white)),
                WidgetSpan(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                )),
                WidgetSpan(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: SvgPicture.asset(
                    'assets/images/crown.svg',
                    height: 10,
                    color: Colors.white,
                  ),
                ))
              ])),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListVouchers(listVouchers: [1, 2, 3, 4, 5, 6]),
        ),
      )),
    );
  }
}
