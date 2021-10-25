import 'dart:io';
import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get_connect/connect.dart';

class ImageProvider extends CommonProvider {
  Future<dynamic> postImage(imageName, imagePath) async {

    FormData data = FormData({
      'imageType' : 1,
      'imageList' : MultipartFile(File(imagePath), filename: imageName)
    });

    final response = await post(UrlStrings.imageUrl, data, headers: await headers);

    if (response.statusCode == 200) {
      return response.body['data'][0];
    }

    return Future.error(response.statusText!);
  }
}
