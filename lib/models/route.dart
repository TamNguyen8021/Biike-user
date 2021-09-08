import 'package:json_annotation/json_annotation.dart';

/// This allows the `Route` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'route.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Route {
  final int routeId;
  final int startingPointId;
  final int destinationId;
  final int defaultPrice;
  final bool isDeleted;

  Route(
    this.routeId,
    this.startingPointId,
    this.destinationId,
    this.defaultPrice,
    this.isDeleted,
  );

  /// A necessary factory constructor for creating a new Route instance
  /// from a map. Pass the map to the generated `_$RouteFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Route.
  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$RouteToJson`.
  Map<String, dynamic> toJson() => _$RouteToJson(this);
}
