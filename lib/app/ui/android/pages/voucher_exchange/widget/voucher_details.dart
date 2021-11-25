import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class VoucherDetails extends StatelessWidget {
  final Voucher voucher;
  VoucherDetails({Key? key, required this.voucher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image(
          image: AssetImage('assets/images/facebook-featured-img.jpg'),
          width: double.infinity,
          height: 150,
          fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            voucher.amountOfPoint.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: CustomColors.kOrange, fontWeight: FontWeight.bold),
                          ),
                          SvgPicture.asset(
                            'assets/images/crown.svg',
                            color: CustomColors.kOrange,
                            height: 12,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          voucher.voucherName,
                          style: Theme.of(context).textTheme.headline2!
                              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                          CustomStrings.kAvailableUntil.tr +
                              DateFormat('dd/MM/yyyy').format(voucher.endDate)
                      )
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          CustomStrings.kVoucherDetail.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          voucher.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          CustomStrings.kTermsAndConditions.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          voucher.termsAndConditions,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}