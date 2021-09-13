import 'package:bikes_user/utils/custom_strings.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  int? userId;

  @JsonKey(defaultValue: '')
  late String userPhoneNumber;

  String? userEmail;

  @JsonKey(defaultValue: CustomStrings.kFindingDriver)
  late String userFullname;

  @JsonKey(defaultValue: 'assets/images/loading.svg')
  late String avatar;

  @JsonKey(defaultValue: -1)
  late int gender;

  int? userStatus;
  String? lastLoginDevice;
  DateTime? lastLoginTime;
  double? userStar;
  DateTime? createDate;
  bool? isBikeVerified;

  User(
      this.userPhoneNumber,
      this.userEmail,
      this.userFullname,
      this.avatar,
      this.gender,
      this.userStatus,
      this.lastLoginDevice,
      this.lastLoginTime,
      this.userStar,
      this.createDate,
      this.isBikeVerified);

  User.empty() {
    this.avatar = '';
    this.userFullname = '';
    this.userPhoneNumber = '';
    this.gender = -1;
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
