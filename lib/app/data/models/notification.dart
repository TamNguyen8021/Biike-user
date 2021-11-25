import 'package:json_annotation/json_annotation.dart';

/// This allows the `Notification` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'notification.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Notification {
  int? notiId;
  int? receiverId;
  String? url;
  DateTime? timeSent;
  bool? isRead;

  Notification({
    required this.notiId,
    required this.receiverId,
    required this.url,
    required this.timeSent,
    required this.isRead
  });

  /// A necessary factory constructor for creating a new Notification instance
  /// from a map. Pass the map to the generated `_$NotificationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Notification.
  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$NotificationToJson`.
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
