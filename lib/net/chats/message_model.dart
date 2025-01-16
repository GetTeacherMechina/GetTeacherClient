import "package:json_annotation/json_annotation.dart";

part "message_model.g.dart";

@JsonSerializable()
class MessageModel {
  MessageModel(
      {required this.id,
      required this.senderId,
      required this.content,
      required this.dateTime,
      required this.senderName});

  factory MessageModel.fromJson(final Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  @JsonKey(name: "Id")
  final int id;

  @JsonKey(name: "SenderId")
  final int senderId;

  @JsonKey(name: "Content")
  final String content;

  @JsonKey(name: "DateTime")
  final DateTime dateTime;

  @JsonKey(name: "SenderName")
  final String senderName;
}
