import "package:json_annotation/json_annotation.dart";

part "get_chats_model.g.dart";

@JsonSerializable()
class ChatUserModel {
  ChatUserModel({required this.id, required this.username});

  factory ChatUserModel.fromJson(final Map<String, dynamic> json) =>
      _$ChatUserModelFromJson(json);

  final int id;
  final String username;
}

@JsonSerializable()
class ChatEntryModel {
  ChatEntryModel({required this.id, required this.users});

  factory ChatEntryModel.fromJson(final Map<String, dynamic> json) =>
      _$ChatEntryModelFromJson(json);

  final int id;
  final List<ChatUserModel> users;
}

@JsonSerializable()
class ChatsModel {
  ChatsModel({required this.chats});

  factory ChatsModel.fromJson(final Map<String, dynamic> json) =>
      _$ChatsModelFromJson(json);

  final List<ChatEntryModel> chats;
}
