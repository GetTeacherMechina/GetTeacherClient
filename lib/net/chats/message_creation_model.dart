import "package:json_annotation/json_annotation.dart";

part "message_creation_model.g.dart";

@JsonSerializable()
class MessageCreationModel {
  MessageCreationModel({required this.content});

  final String content;
  Map<String, dynamic> toJson() => _$MessageCreationModelToJson(this);
}
