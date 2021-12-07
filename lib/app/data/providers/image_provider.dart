import 'dart:convert';

import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:http/http.dart' as http;

class ImageProvider extends CommonProvider {
  /// Upload an image to server and get the image url
  ///
  /// Author: PhatDH
  Future<List> postImage(
      {required int imageType,
      required List<http.MultipartFile> imageList}) async {
    var request = http.MultipartRequest('POST', Uri.parse(UrlStrings.imageUrl));

    request.fields.addAll({'imageType': imageType.toString()});
    for (http.MultipartFile image in imageList) {
      request.files.add(image);
    }

    request.headers.addAll(await headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 200 || response.statusCode > 299) {
      return Future.error(response.statusCode);
    } else {
      return jsonDecode(await response.stream.bytesToString())['data'];
    }
  }
}
