import 'dart:convert';

class BlackListResponse {
  BlackListResponse({
    required this.message,
    required this.data,
  });

  String message;
  List<BlackListItem> data;

  factory BlackListResponse.fromRawJson(String str) =>
      BlackListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlackListResponse.fromJson(Map<String, dynamic> json) =>
      BlackListResponse(
        message: json["message"] ?? '',
        data: json["data"] == null
            ? []
            : List<BlackListItem>.from(
                json["data"].map((x) => BlackListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BlackListItem {
  BlackListItem({
    required this.userOneId,
    required this.userTwoId,
    required this.isBlock,
    this.blockTime,
    this.unBlockTime,
    required this.userName,
  });

  int userOneId;
  int userTwoId;
  bool isBlock;
  DateTime? blockTime;
  dynamic unBlockTime;
  String userName;

  factory BlackListItem.fromRawJson(String str) =>
      BlackListItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlackListItem.fromJson(Map<String, dynamic> json) => BlackListItem(
      userOneId: json["userOneId"] ?? -1,
      userTwoId: json["userTwoId"] ?? -1,
      isBlock: json["isBlock"] ?? false,
      blockTime: DateTime.tryParse(json["blockTime"]),
      unBlockTime: json["unBlockTime"],
      userName: json['userName'] ?? '');

  Map<String, dynamic> toJson() => {
        "userOneId": userOneId,
        "userTwoId": userTwoId,
        "isBlock": isBlock,
        "blockTime": blockTime == null ? null : blockTime!.toIso8601String(),
        "unBlockTime": unBlockTime,
        "userName" : userName,
      };
}
