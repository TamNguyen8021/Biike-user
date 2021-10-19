import 'package:bikes_user/app/ui/android/pages/your_voucher/widget/your_voucher_card.dart';
import 'package:flutter/material.dart';

class YourVoucherList extends StatelessWidget {
  final List listVouchers;

  const YourVoucherList({Key? key, required this.listVouchers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listVouchers.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: YourVoucherCard(data: listVouchers[i]),
          );
        });
  }
}
