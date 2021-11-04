import 'dart:io';
import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get_connect/connect.dart';

class ImageProvider extends CommonProvider {
  Future<dynamic> postImage(
      {required int imageType,
      required String imageName,
      required dynamic imagePath}) async {
    FormData data = FormData({
      'imageType': imageType,
      'imageList': MultipartFile(File(imagePath), filename: imageName)
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
