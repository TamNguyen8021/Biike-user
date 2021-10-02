import 'package:json_annotation/json_annotation.dart';

/// This allows the `Wallet` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'wallet.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Wallet {
  final int? walletId;
  final int? userId;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? point;
  final int? walletStatus;

  Wallet(this.walletId, this.userId, this.fromDate, this.toDate, this.point,
      this.walletStatus);

  /// A necessary factory constructor for creating a new Wallet instance
  /// from a map. Pass the map to the generated `_$WalletFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Wallet.
  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$WalletToJson`.
  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
