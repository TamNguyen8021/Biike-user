import 'package:json_annotation/json_annotation.dart';

/// This allows the `BiikeNoti` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'notification.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class BiikeNoti {
  // int? notiId;
  int? receiverId;
  String? title;
  String? content;
  String? url;
  DateTime? createdDate;
  bool? isRead;

  BiikeNoti(
      {
      // required this.notiId,
      required this.receiverId,
      required this.title,
      required this.content,
      required this.url,
      required this.createdDate,
      this.isRead = false});

  BiikeNoti.empty() {
    receiverId = 10;
    title = 'title';
    content = 'content';
    url = 'url';
    createdDate = DateTime.now();
  }

  /// A necessary factory constructor for creating a new BiikeNoti instance
  /// from a map. Pass the map to the generated `_$NotificationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, BiikeNoti.
  factory BiikeNoti.fromJson(Map<dynamic, dynamic> json) =>
      _$BiikeNotiFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$NotificationToJson`.
  Map<String, dynamic> toJson() => _$BiikeNotiToJson(this);
}
