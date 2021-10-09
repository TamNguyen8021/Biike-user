import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class YourVoucherCard extends StatelessWidget {
  final data;
  YourVoucherCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Voucher voucher = Voucher.fromJson(data);
    return GestureDetector(
        onTap: () => Get.toNamed(
            CommonRoutes.YOUR_VOUCHER_DETAIL,
            arguments: data),

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
                  child: Image(
                    image: AssetImage('assets/images/voucher-banh-mi.jpg'),
                    width: 100,
                    height: 120,
                    fit: BoxFit.fill,
                    // height: 100,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    // 'Voucher Passio\nTrị giá 20.000đ',
                    voucher.voucherName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      // 'Áp dụng khi mua tại cửa hàng\nvới hóa đơn từ 100k',
                      CustomStrings.kBrand.tr + voucher.brand,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      CustomStrings.kHsd.tr +
                          DateFormat('dd/MM/yyyy').format(voucher.endDate),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: CustomColors.kOrange),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
