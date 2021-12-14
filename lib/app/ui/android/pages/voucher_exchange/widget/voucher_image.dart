import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:flutter/material.dart';

class VoucherImages extends StatelessWidget {
  final Voucher voucher;
  final bool isIcon;

  VoucherImages({Key? key, required this.voucher, required this.isIcon})
      : super(key: key);

  AssetImage get _placeholder => isIcon
      ? AssetImage('assets/images/voucher-ngoai.jpg')
      : AssetImage('assets/images/voucher-trong.jpg');

  double get _height => isIcon ? 100 : 150;
  double get _width => isIcon ? 100 : double.infinity;
  int get _imageIndex => isIcon ? 0 : 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: voucher.voucherImages != null &&
              voucher.voucherImages!.length > _imageIndex &&
              voucher.voucherImages!.elementAt(_imageIndex) != null
          ? FadeInImage(
              width: _width,
              height: _height,
              fit: BoxFit.fill,
              placeholder: _placeholder,
              image: NetworkImage(voucher.voucherImages!
                  .elementAt(_imageIndex)!
                  .voucherImageUrl
                  .toString()),
            )
          : Image(
              image: _placeholder,
              width: _width,
              height: _height,
              fit: BoxFit.fill,
            ),
    );
  }
}
