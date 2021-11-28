import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  VoucherCard({Key? key, required this.voucher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            Get.toNamed(CommonRoutes.VOUCHER_DETAILS, arguments: voucher),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
              color: CustomColors.kLightGray,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: CustomColors.kDarkGray.withOpacity(0.3),
                  // changes position of shadow
                  offset: Offset(0, 1),
                )
              ]),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: voucher.voucherImages.elementAt(0) != null
                      ? Image(
                          image: NetworkImage(voucher.voucherImages
                              .elementAt(0)!
                              .voucherImageUrl
                              .toString()),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        )  // img from link
                      : Image(
                          image:
                              AssetImage('assets/images/voucher-banh-mi.jpg'),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ), // img from asset package
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    voucher.voucherName,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      CustomStrings.kBrand.tr + voucher.brand,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          voucher.amountOfPoint.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: CustomColors.kOrange),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: SvgPicture.asset(
                          'assets/images/crown.svg',
                          color: CustomColors.kOrange,
                          height: 12,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
