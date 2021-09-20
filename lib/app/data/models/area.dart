import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart';

/// This allows the `Area` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'area.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable(fieldRename: FieldRename.snake)
class Area {
  late final int? areaId;

  @JsonKey(defaultValue: CustomStrings.fptHCMUni)
  late final String areaName;

  late final bool? isAreaDeleted;

  Area(
    this.areaId,
    this.areaName,
    this.isAreaDeleted,
  );

  Area.empty() {
    areaName = '';
  }

  /// A necessary factory constructor for creating a new Area instance
  /// from a map. Pass the map to the generated `_$AreaFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Area.
  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$AreaToJson`.
  Map<String, dynamic> toJson() => _$AreaToJson(this);
}
