import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/models/advertisment_model.dart';
import 'package:bikes_user/network/repositories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AdContainer extends HookWidget {
  AdContainer({
    Key? key,
    required this.advertisment,
  }) : super(key: key);
  final Advertisment advertisment;

  final double heightImage = 150;
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
          children: <Widget>[
            Positioned.fill(
              child: CarouselSlider.builder(
                itemCount: advertisment.advertisementImages.length,
                itemBuilder: (context, index, realIndex) {
                  final item = advertisment.advertisementImages[index];

                  return GestureDetector(
                    onTap: () async {
                      CommonFunctions.openLink(
                          context: context, url: advertisment.advertisementUrl);

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
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                            width: double.infinity,
                            height: heightImage,
                            child: Loading());
                      },
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    indexState.value = index;
                  },
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                ),
              ),
            ),
            if (advertisment.advertisementImages.length > 1) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: advertisment.advertisementImages
                    .asMap()
                    .entries
                    .map((entry) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
          ],
        ),
      ),
    );
  }
}
