enum ImageType { bike, user, voucher, advertisement }

extension ImageTypeExtension on ImageType {
  /// Convert [imageType] to integer
  ///
  /// Author: TamNTT
  int getImageTypeInt(ImageType imageType) {
    switch (imageType) {
      case ImageType.bike:
        return 1;
      case ImageType.user:
        return 2;
      case ImageType.voucher:
        return 3;
      case ImageType.advertisement:
        return 4;
      default:
        return -1;
    }
  }
}
