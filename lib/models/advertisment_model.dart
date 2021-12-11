import 'dart:convert';

class AdvertismentModel {
  AdvertismentModel({
    required this.message,
    required this.data,
  });

  String message;
  List<Advertisment> data;

  factory AdvertismentModel.fromRawJson(String str) =>
      AdvertismentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdvertismentModel.fromJson(Map<String, dynamic> json) =>
      AdvertismentModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Advertisment>.from(
                json["data"].map((x) => Advertisment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Advertisment {
  Advertisment({
    required this.advertisementId,
    required this.advertisementUrl,
    required this.brand,
    required this.title,
    required this.advertisementAddresses,
    required this.advertisementImages,
  });

  int advertisementId;
  String advertisementUrl;
  String brand;
  String title;

  List<AdvertisementAddress> advertisementAddresses;
  List<AdvertisementImage> advertisementImages;

  factory Advertisment.fromRawJson(String str) =>
      Advertisment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Advertisment.fromJson(Map<String, dynamic> json) => Advertisment(
        advertisementId: json["advertisementId"],
        advertisementUrl: json["advertisementUrl"] ?? '',
        brand: json["brand"] ?? '',
        title: json["title"] ?? '',
        advertisementAddresses: List<AdvertisementAddress>.from(
            json["advertisementAddresses"]
                .map((x) => AdvertisementAddress.fromJson(x))),
        advertisementImages: json["advertisementImages"] == null
            ? []
            : List<AdvertisementImage>.from(json["advertisementImages"]
                .map((x) => AdvertisementImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "advertisementId": advertisementId,
        "advertisementUrl": advertisementUrl,
        "brand": brand,
        "title": title,
        "advertisementAddresses":
            List<dynamic>.from(advertisementAddresses.map((x) => x.toJson())),
        "advertisementImages":
            List<dynamic>.from(advertisementImages.map((x) => x.toJson())),
      };
}

class AdvertisementAddress {
  AdvertisementAddress({
    required this.addressId,
    required this.addressName,
    required this.addressDetail,
    required this.addressCoordinate,
  });

  int addressId;
  String addressName;
  String addressDetail;
  String addressCoordinate;

  factory AdvertisementAddress.fromRawJson(String str) =>
      AdvertisementAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdvertisementAddress.fromJson(Map<String, dynamic> json) =>
      AdvertisementAddress(
        addressId: json["addressId"],
        addressName: json["addressName"] ?? '',
        addressDetail: json["addressDetail"] ?? '',
        addressCoordinate: json["addressCoordinate"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "addressId": addressId,
        "addressName": addressName,
        "addressDetail": addressDetail,
        "addressCoordinate": addressCoordinate,
      };
}

class AdvertisementImage {
  AdvertisementImage({
    required this.advertisementImageId,
    required this.advertisementImageUrl,
  });

  int advertisementImageId;
  String advertisementImageUrl;

  factory AdvertisementImage.fromRawJson(String str) =>
      AdvertisementImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdvertisementImage.fromJson(Map<String, dynamic> json) =>
      AdvertisementImage(
        advertisementImageId: json["advertisementImageId"],
        advertisementImageUrl: json["advertisementImageUrl"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "advertisementImageId": advertisementImageId,
        "advertisementImageUrl": advertisementImageUrl,
      };
}
