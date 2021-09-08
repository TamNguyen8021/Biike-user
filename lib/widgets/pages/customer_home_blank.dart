import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/buttons/create_trip_button.dart';
import 'package:bikes_user/widgets/others/top_biker.dart';
import 'package:bikes_user/widgets/painters/tooltip_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerHomeBlank extends StatelessWidget {
  const CustomerHomeBlank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: <Widget>[
              TopBiker(),
              SvgPicture.asset('assets/images/blank.svg'),
              CustomPaint(
                foregroundPainter: TooltipPainter(),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: CustomColors.kLightGray,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    CustomStrings.kCreateTrip,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
      floatingActionButton: CreateTripButton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
