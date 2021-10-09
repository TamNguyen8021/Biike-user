import 'package:json_annotation/json_annotation.dart';

/// This allows the `DestinationStation` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'redemption.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Redemption {
  final int redemptionId;
  final int walletId;
  final int voucherId;
  final String voucherCode;
  final int voucherPoint;
  final bool isUsed;
  final DateTime redemptionDate;

  Redemption({
    required this.redemptionId,
    required this.walletId,
    required this.voucherId,
    required this.voucherCode,
    required this.voucherPoint,
    required this.isUsed,
    required this.redemptionDate,
  });

  /// A necessary factory constructor for creating a new DestinationStation instance
  /// from a map. Pass the map to the generated `_$DestinationStationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, DestinationStation.
  factory Redemption.fromJson(Map<String, dynamic> json) =>
      _$RedemptionFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$DestinationStationToJson`.
  Map<String, dynamic> toJson() => _$RedemptionToJson(this);
}
