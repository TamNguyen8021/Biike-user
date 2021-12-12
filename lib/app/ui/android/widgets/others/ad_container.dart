import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/models/advertisment_model.dart';
import 'package:bikes_user/network/repositories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

class AdContainer extends HookWidget {
  AdContainer({
    Key? key,
    required this.advertisment,
  }) : super(key: key);
  final Advertisment advertisment;

  final double heightImage = 120;
  @override
  Widget build(BuildContext context) {
    final indexState = useState(0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: double.infinity,
        height: heightImage,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: CarouselSlider.builder(
                itemCount: advertisment.advertisementImages.length,
                itemBuilder: (context, index, realIndex) {
                  final item = advertisment.advertisementImages[index];

                  return GestureDetector(
                    onTap: () async {
                      _launchUniversalLinkIos(advertisment.advertisementUrl);

                      final _repositories = getIt<Repositories>();
                      try {
                        await _repositories.clickAdsCount(
                            adsId: advertisment.advertisementId.toString());
                      } catch (e) {}
                    },
                    child: Image.network(
                      item.advertisementImageUrl,
                      cacheHeight: 300,
                      cacheWidth: 300,
                      width: double.infinity,
                      height: heightImage,
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Lỗi hình ảnh');
                      },
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                          width: double.infinity,
                          height: heightImage,
                        );
                      },
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 1,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    indexState.value = index;
                  },
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  advertisment.advertisementImages.asMap().entries.map((entry) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: indexState.value == entry.key
                        ? Colors.grey
                        : Colors.black,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUniversalLinkIos(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: false,
          enableJavaScript: true,
        );
      } else {
        // show thong bao khong mo duoc
        print('can not open $url');
      }
    } catch (error) {
      // loi ngoai le
      CommonFunctions.catchExceptionError(error);
    }
  }
}
