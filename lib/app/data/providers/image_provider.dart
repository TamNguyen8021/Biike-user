import 'dart:io';
import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get_connect/connect.dart';

class ImageProvider extends CommonProvider {
  Future<dynamic> postImage(
      {required int imageType,
      required String imageName,
      required dynamic imagePath}) async {
    // var file = await DefaultCacheManager().getSingleFile(imagePath);
    final File imageFile = File(imagePath);

    Biike.logger.d(imageFile);

    if (await imageFile.exists()) {
      // Use the cached images if it exists
    } else {
      // Image doesn't exist in cache
      await imageFile.create(recursive: true);
    }

    FormData data = FormData({
      'imageType': imageType,
      'imageList': MultipartFile(imageFile, filename: imageName)
    });

    data.fields.forEach((element) {
      Biike.logger.d(element.key + ':' + element.value);
    });

    final response =
        await post(UrlStrings.imageUrl, data, headers: await headers);

    logResponse(response);

    if (response.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body['data'][0];
    }
  }
}
