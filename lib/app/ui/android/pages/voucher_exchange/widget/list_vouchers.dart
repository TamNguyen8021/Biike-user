import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/voucher_card.dart';
import 'package:flutter/material.dart';

class ListVouchers extends StatelessWidget {
  final List listVouchers;

  const ListVouchers({Key? key, required this.listVouchers}) : super(key: key);

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
            child: VoucherCard(voucher: Voucher.fromJson(listVouchers[i])),
          );
        });
  }
}
