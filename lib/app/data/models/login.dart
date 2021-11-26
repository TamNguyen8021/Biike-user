// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

class LoginResponse {
  LoginResponse({
    required this.message,
    required this.data,
  });

  String message;
  LoginData data;

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        data: LoginData.fromJson(json["data"]),
      );
}

class LoginData {
  LoginData({
    required this.userId,
    required this.email,
    required this.displayName,
    required this.profilePicture,
    required this.idToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.phone,
    required this.isPhoneVerified,
  });

  String userId;
  String email;
  String displayName;
  String profilePicture;
  String idToken;
  String refreshToken;
  String expiresIn;
  String phone;
  bool isPhoneVerified;

  factory LoginData.fromRawJson(String str) =>
      LoginData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        userId: json["userId"] ?? '',
        email: json["email"] ?? '',
        displayName: json["displayName"] ?? '',
        profilePicture: json["profilePicture"] ?? '',
        idToken: json["idToken"] ?? '',
        refreshToken: json["refreshToken"] ?? '',
        expiresIn: json["expiresIn"] ?? '',
        phone: json['phone'] ?? '',
        isPhoneVerified: json['isPhoneVerified'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "displayName": displayName,
        "profilePicture": profilePicture,
        "idToken": idToken,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "phone": phone,
        "isPhoneVerified": isPhoneVerified,
      };
}
