import 'package:bikes_user/app/data/providers/image_provider.dart';
import 'package:get/get.dart';

class ImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ImageProvider());
  }
}
