import 'dart:convert';
import 'dart:typed_data';

import 'package:bikes_user/app/common/functions/rsa_utils.dart';
import 'package:bikes_user/app/common/functions/text_utils.dart';
import 'package:bikes_user/app/common/values/momo_constants.dart';
import 'package:bikes_user/app/controllers/top_up_point_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momo_vn/momo_vn.dart';

/// The 'top_up_point' screen
class TopUpPointPage extends StatefulWidget {
  @override
  MomoPageState createState() => MomoPageState();
}

class MomoPageState extends State<TopUpPointPage> {
  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  late String _paymentStatus;
  final topUpPointController = Get.find<TopUpPointController>();

  @override
  void initState() {
    super.initState();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _paymentStatus = "";
    // initPlatformState();
    setState(() {});
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
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
                            MomoPaymentInfo options = MomoPaymentInfo(
                                merchantName: "Biiké",
                                appScheme: "momo6z6g20200121",
                                merchantCode: MomoConstants.partnerCode,
                                partnerCode: MomoConstants.partnerCode,
                                amount: 1000,
                                orderId: TextUtils.getOrderId(),
                                orderLabel: 'Nạp điểm',
                                merchantNameLabel: "TTND",
                                fee: 0,
                                description: 'Thanh toán nạp điểm',
                                username: 'Biiké',
                                partner: 'merchant',
                                isTestMode: true
                            );
                            try {
                              _momoPay.open(options);
                            } catch (e) {
                              print(e.toString());
                            }
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

  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      _paymentStatus += "\nTình trạng: Thành công.";
      _paymentStatus += "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
      _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
    }
    else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });

    Map<String, dynamic> paymentRequest = {
      'partnerCode': MomoConstants.partnerCode,
      'partnerRefId': TextUtils.getRefId(),
      'partnerTransId':TextUtils.getTransId(),
      'amount': 1000,
    };

    RSAUtils rsaUtils = RSAUtils(MomoConstants.pubKey);

    List<int> unit8List = json.encode(paymentRequest).codeUnits;

    Map<String, dynamic> payment = {
      'customerNumber': response.phoneNumber,
      'appData': response.token!.trim(),
      'partnerCode': paymentRequest['partnerCode'],
      'partnerRefId': paymentRequest['partnerRefId'],
      'hash': rsaUtils.encryptStr(Uint8List.fromList(unit8List)),
      'description': 'Thanh toán nạp điểm',
      'version': 2
    };

    topUpPointController.createPayment(body: payment);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    print("Thất bại");
  }
}
