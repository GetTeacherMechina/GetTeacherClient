import "package:json_annotation/json_annotation.dart";

part "chat_creation_model.g.dart";

@JsonSerializable()
class ChatCreationModel {
  ChatCreationModel({required this.users});

  @JsonKey(name: "Users")
  final List<int> users;

  Map<String, dynamic> toJson() => _$ChatCreationModelToJson(this);
}
