import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/top_up_point_controller.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/custom_elevated_icon_has_loading_button.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/top_up_point_text_field.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'top_up_point' screen
class TopUpPointPage extends StatefulWidget {
  @override
  MomoPageState createState() => MomoPageState();
}

class MomoPageState extends State<TopUpPointPage> {
  // late MomoVn _momoPay;
  // late PaymentResponse _momoPaymentResult;
  String paymentStatus = '';
  final topUpPointController = Get.find<TopUpPointController>();

  @override
  void initState() {
    super.initState();
    // _momoPay = MomoVn();
    // _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var percentTransfer =
        double.parse(topUpPointController.percent.value) * 1000;

    return FutureBuilder(
        future: topUpPointController.getConfigurations(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() => Scaffold(
                  appBar: CustomAppBar(
                    isVisible: true,
                    hasShape: true,
                    hasLeading: true,
                    onPressedFunc: () {
                      Get.back();
                    },
                    appBar: AppBar(),
                    title: Text(CustomStrings.kBuyPoint.tr),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  CustomStrings.kTopUpFromMomo.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                ))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(CustomStrings.kEnterPoint.tr),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: TopUpPointTextField(
                                      hintText: '',
                                      isReadOnly: false,
                                      isEditPoint: true,
                                      initialValue:
                                          '${topUpPointController.point}',
                                      labelText: '',
                                      onChangeFunc: (value) => {
                                        if (value.isNotEmpty)
                                          {
                                            topUpPointController
                                                .setAmount(value)
                                          }
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child:
                                        Text('1000 đ = $percentTransfer điểm'),
                                  )
                                ],
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        CustomStrings.kNeedAmount.tr,
                                        style: TextStyle(
                                            color: CustomColors.kBlue,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${topUpPointController.amount} đ',
                                          style: TextStyle(
                                              color: CustomColors.kBlue,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  CustomStrings.kNoted.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    CustomStrings.kTopUpNoted.tr,
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: CustomElevatedIconHasLoadingButton(
                            onPressedFunc: () async {
                              // MomoPaymentInfo options = MomoPaymentInfo(
                              //     merchantName: 'Biiké',
                              //     appScheme: 'momo6z6g20200121',
                              //     merchantCode: MomoConstants.partnerCode,
                              //     partnerCode: MomoConstants.partnerCode,
                              //     amount: int.parse(
                              //         topUpPointController.amount.value),
                              //     orderId: TextUtils.getOrderId(),
                              //     orderLabel: 'Nạp điểm',
                              //     merchantNameLabel: 'TTND',
                              //     fee: 0,
                              //     description: 'Thanh toán nạp điểm',
                              //     username: 'Biiké',
                              //     partner: 'merchant',
                              //     isTestMode: true);
                              // try {
                              //   _momoPay.open(options);
                              // } catch (e) {
                              //   print(e.toString());
                              // }
                            },
                            text: CustomStrings.kBuyPoint.tr,
                            icon: Icons.save,
                            elevation: 0.0,
                            backgroundColor: CustomColors.kBlue,
                            foregroundColor: Colors.white,
                            isLoading: topUpPointController.isLoading,
                          ),
                        )
                      ],
                    ),
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
    // _momoPay.clear();
  }

  // void _setState() {
  // paymentStatus = 'Đã chuyển thanh toán';
  // if (_momoPaymentResult.isSuccess == true) {
  //   paymentStatus += '\nTình trạng: Thành công.';
  //   paymentStatus +=
  //       '\nSố điện thoại: ' + _momoPaymentResult.phoneNumber.toString();
  //   paymentStatus += '\nExtra: ' + _momoPaymentResult.extra!;
  //   paymentStatus += '\nToken: ' + _momoPaymentResult.token.toString();
  // } else {
  //   paymentStatus += '\nTình trạng: Thất bại.';
  //   paymentStatus += '\nExtra: ' + _momoPaymentResult.extra.toString();
  //   paymentStatus += '\nMã lỗi: ' + _momoPaymentResult.status.toString();
  // }
  // }

  // void _handlePaymentSuccess(PaymentResponse response) {
  //   setState(() {
  //     _momoPaymentResult = response;
  //     _setState();
  //   });

  //   Map<String, dynamic> paymentRequest = {
  //     'partnerCode': MomoConstants.partnerCode,
  //     'partnerRefId': TextUtils.getRefId(),
  //     'partnerTransId': TextUtils.getTransId(),
  //     'amount': int.parse(topUpPointController.amount.value),
  //   };

  //   RSAUtils rsaUtils = RSAUtils(MomoConstants.pubKey);

  //   List<int> unit8List = json.encode(paymentRequest).codeUnits;

  //   Map<String, dynamic> payment = {
  //     'customerNumber': response.phoneNumber,
  //     'appData': response.token!.trim(),
  //     'partnerCode': paymentRequest['partnerCode'],
  //     'partnerRefId': paymentRequest['partnerRefId'],
  //     'hash': rsaUtils.encryptStr(Uint8List.fromList(unit8List)),
  //     'description': 'Thanh toán nạp điểm',
  //     'version': 2
  //   };

  //   topUpPointController.createPayment(context: context, body: payment);
  // }

  // void _handlePaymentError(PaymentResponse response) {
  //   setState(() {
  //     _momoPaymentResult = response;
  //     _setState();
  //   });
  //   Biike.logger.e('_handlePaymentError: failed');
  // }
}
