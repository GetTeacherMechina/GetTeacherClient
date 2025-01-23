import "package:json_annotation/json_annotation.dart";

part "message_model.g.dart";

@JsonSerializable()
class MessageModel {
  MessageModel({
    required this.id,
    required this.senderId,
    required this.content,
    required this.dateTime,
    required this.senderName,
  });

  factory MessageModel.fromJson(final Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "senderId")
  final int senderId;

  @JsonKey(name: "content")
  final String content;

  @JsonKey(name: "dateTime")
  final DateTime dateTime;

  @JsonKey(name: "senderName")
  final String senderName;
}
