
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/pages/login/login_page.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/models/on_board/on_board.dart';
import 'package:bikes_user/resource/images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import 'widgets/dots_widget.dart';
import 'widgets/item_onboard_widget.dart';

/// The '001.2_onboard ' screen
class OnBoardScreen extends HookWidget {
  static const String routeName = '/onBoard';

  OnBoardScreen({Key? key}) : super(key: key);

  final List<OnBoardItems> listOnBoard = [
    OnBoardItems(
      des: CustomStrings.kFirstDescription,
      pathImage: ImageResource.handOnboard,
      title: CustomStrings.kFree,
    ),
    OnBoardItems(
        des: CustomStrings.kSecondDescription,
        pathImage: ImageResource.roundedOnBoard,
        title: CustomStrings.kConnectSociety),
    OnBoardItems(
      des: CustomStrings.kThirdDescription,
      pathImage: ImageResource.herbOnBoard,
      title: CustomStrings.kProtectEnvironment,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final indexState = useState(0);
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
                      child: Text(CustomStrings.kSkip,
                          style: TextStyle(color: Colors.white, fontSize: 19)),
                      onPressed: () {
                        Get.offAllNamed(LoginPage.routeName);
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
                            options: _carouselOptions(indexState),
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

  CarouselOptions _carouselOptions(ValueNotifier<int> indexState) {
    return CarouselOptions(
      viewportFraction: 1,
      autoPlay: false,
      enlargeCenterPage: false,
      aspectRatio:0.6,
      onPageChanged: (index, _) {
        indexState.value = index;
      },
    );
  }
}
