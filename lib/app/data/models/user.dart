import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class User {
  @JsonKey(defaultValue: -1)
  late int userId;

  @JsonKey(defaultValue: '')
  late String userPhoneNumber;

  @JsonKey(defaultValue: '')
  late String email;

  @JsonKey(defaultValue: CustomStrings.kFinding)
  late String userFullname;

  @JsonKey(defaultValue: '')
  late String avatar;

  @JsonKey(defaultValue: -1)
  late int gender;

  String? birthDate;

  int? userStatus;
  String? lastLoginDevice;
  DateTime? lastLoginTime;

  @JsonKey(defaultValue: 0.0)
  late double userStar;

  @JsonKey(defaultValue: 0)
  late int totalPoint;

  DateTime? createDate;
  bool? isBikeVerified;
  bool? isEmailVerified;
  bool? isPhoneVerified;

  User(
      this.userPhoneNumber,
      this.email,
      this.userFullname,
      this.avatar,
      this.gender,
      this.birthDate,
      this.userStatus,
      this.lastLoginDevice,
      this.lastLoginTime,
      this.userStar,
      this.createDate,
      this.isBikeVerified,
      this.isEmailVerified,
      this.isPhoneVerified);

  User.empty() {
    this.userId = -1;
    this.avatar = '';
    this.email = '';
    this.userFullname = '';
    this.userPhoneNumber = '';
    this.gender = -1;
    this.userStar = 0.0;
    this.totalPoint = 0;
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
