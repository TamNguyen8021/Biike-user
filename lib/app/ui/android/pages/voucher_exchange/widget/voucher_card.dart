import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VoucherCard extends StatelessWidget {
  final data;
  final bool isExchanged;

  VoucherCard({Key? key, required this.data, this.isExchanged = false})
      : super(key: key);

  ImageProvider _getImage(voucher) {
    if (voucher.voucherImages.length > 0) {
      var imageLink =
          voucher.voucherImages.elementAt(0)!.voucherImageUrl.toString();
      if (imageLink != '') return NetworkImage(imageLink);
    }
    return AssetImage('assets/images/voucher-banh-mi.jpg');
  }

  @override
  Widget build(BuildContext context) {
    Voucher voucher = Voucher.fromJson(data);
    var now = DateTime.now();

    return GestureDetector(
        onTap: () => isExchanged
            ? Get.toNamed(CommonRoutes.YOUR_VOUCHER_DETAIL, arguments: data)
            : Get.toNamed(CommonRoutes.VOUCHER_DETAILS, arguments: voucher),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
              color: now.isAfter(voucher.endDate)
                  ? CustomColors.kDarkGray
                  : CustomColors.kLightGray,
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
                  child: Image(
                    image: _getImage(voucher),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
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
                  isExchanged
                      ? Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            CustomStrings.kHsd.tr +
                                DateFormat('dd/MM/yyyy')
                                    .format(voucher.endDate),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: CustomColors.kOrange),
                          ),
                        )
                      : Row(
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
                        ),
                ],
              )
            ],
          ),
        ));
  }
}
