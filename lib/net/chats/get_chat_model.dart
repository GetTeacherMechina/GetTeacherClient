import "package:getteacher/net/chats/message_model.dart";
import "package:json_annotation/json_annotation.dart";

part "get_chat_model.g.dart";

@JsonSerializable()
class ChatModel {
  ChatModel({required this.users, required this.messages});

  factory ChatModel.fromJson(final Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  @JsonKey(name: "Users")
  final List<int> users;

  @JsonKey(name: "Messages")
  final List<MessageModel> messages;
}
