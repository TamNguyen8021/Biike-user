import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momo_payment/momo_payment.dart';
import 'package:momo_payment/momo_payment_data.dart';
// import 'package:momo_vn/momo_vn.dart';

/// The 'top_up_point' screen
class TopUpPointPage extends StatefulWidget {
  @override
  MomoPageState createState() => MomoPageState();
}
class MomoPageState extends State<TopUpPointPage> {
  // late MomoVn _momoPay;
  // late PaymentResponse _momoPaymentResult;
  // late String _paymentStatus;
  MomoPayment _momoPayment = new MomoPayment();

  @override
  void initState() {
    super.initState();
    // _momoPay = MomoVn();
    // _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _paymentStatus = "";
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        onPressedFunc: () {
          Get.back();
        },
        appBar: AppBar(),
        title: Text(CustomStrings.kAddAddressBook.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: CustomElevatedIconButton(
                          onPressedFunc: () async {
                            MomoPaymentData data = MomoPaymentData(
                              merchantname: "Biiké",
                              merchantcode: "MOMO6Z6G20200121",
                              partnerCode: "MOMO6Z6G20200121",
                              appScheme: "MOMO6Z6G20200121",
                              amount: 1000,
                              orderId: "order01",
                              orderLabel: "Book ABC",
                              isDevelopmentMode: true,
                            );
                            _momoPayment.requestPayment(data);
                            // try {
                            //   _momoPay.open(options);
                            // } catch (e) {
                            //   debugPrint(e.toString());
                            // }
                          },
                          text: CustomStrings.kBuyPoint.tr,
                          icon: Icons.save,
                          elevation: 0.0,
                          backgroundColor: CustomColors.kBlue,
                          foregroundColor: Colors.white,
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _momoPay.clear();
  // }
  // void _setState() {
  //   _paymentStatus = 'Đã chuyển thanh toán';
  //   if (_momoPaymentResult.isSuccess == true) {
  //     _paymentStatus += "\nTình trạng: Thành công.";
  //     _paymentStatus += "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
  //     _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
  //     _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
  //   }
  //   else {
  //     _paymentStatus += "\nTình trạng: Thất bại.";
  //     _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
  //     _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
  //   }
  // }
  // void _handlePaymentSuccess(PaymentResponse response) {
  //   setState(() {
  //     _momoPaymentResult = response;
  //     _setState();
  //   });
  //   print("Thành công");
  // }
  //
  // void _handlePaymentError(PaymentResponse response) {
  //   setState(() {
  //     _momoPaymentResult = response;
  //     _setState();
  //   });
  //   print("Thất bại");
  // }
}
