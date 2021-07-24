import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/buttons/custom_floating_button.dart';
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
          // height: double.infinity,
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SvgPicture.asset('assets/images/blank.svg'),
              ),
              Text(
                CustomStrings.kCreateTrip,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        )),
      ),
      floatingActionButton: CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
