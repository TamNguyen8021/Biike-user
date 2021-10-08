import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/common/values/images.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/on_board/on_board/on_board.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widgets/dots_widget.dart';
import 'widgets/item_onboard_widget.dart';

/// The '001.2_onboard ' screen
class OnBoardPage extends StatefulWidget {
  OnBoardPage({Key? key}) : super(key: key);

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  late int indexState;
  final FirebaseServices _firebaseServices = getIt<FirebaseServices>();
  Future<void> skip() async {
    if (_firebaseServices.user != null) {
      Get.offAllNamed(CommonRoutes.HOME);
    } else {
      Get.offAllNamed(CommonRoutes.LOGIN);
    }
    return;
  }

  @override
  void initState() {
    indexState = 0;
    super.initState();
  }

  final List<OnBoardItems> listOnBoard = [
    OnBoardItems(
      des: CustomStrings.kFirstDescription.tr,
      pathImage: ImageResource.handOnboard,
      title: CustomStrings.kFree.tr,
    ),
    OnBoardItems(
        des: CustomStrings.kSecondDescription.tr,
        pathImage: ImageResource.roundedOnBoard,
        title: CustomStrings.kConnectSociety.tr),
    OnBoardItems(
      des: CustomStrings.kThirdDescription.tr,
      pathImage: ImageResource.herbOnBoard,
      title: CustomStrings.kProtectEnvironment.tr,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 0.2,
              image: AssetImage('assets/images/line-map.png'),
              fit: BoxFit.fitWidth,
              color: CustomColors.kLightGray.withOpacity(0.1),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(CustomStrings.kSkip.tr,
                          style:
                              TextStyle(color: Colors.white, fontSize: 19.sp)),
                      onPressed: () {
                        skip();
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: CarouselSlider.builder(
                            itemBuilder: (context, index, realIndex) {
                              final itemOnBoard = listOnBoard[index];
                              return ItemOnBoardWidget(
                                  itemOnBoard: itemOnBoard);
                            },
                            options: _carouselOptions(),
                            itemCount: listOnBoard.length,
                          ),
                        ),
                        // dot
                        DotsWidget(
                            listOnBoard: listOnBoard, indexState: indexState),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  CarouselOptions _carouselOptions() {
    return CarouselOptions(
      viewportFraction: 1,
      autoPlay: false,
      enlargeCenterPage: false,
      aspectRatio: 0.6,
      onPageChanged: (index, _) {
        setState(() {
          indexState = index;
        });
      },
    );
  }
}
