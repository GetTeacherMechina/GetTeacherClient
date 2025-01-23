import "package:getteacher/net/net.dart";
import "package:json_annotation/json_annotation.dart";

part 'users.g.dart';

Future<List<UserData>> getAllUsers() async {
  final data = await getClient().getJson("/users");

  return (data["users"] as List<dynamic>)
      .map((final a) => UserData.fromJson(a as Map<String, dynamic>))
      .toList();
}

@JsonSerializable()
class UserData {
  UserData({
    required this.id,
    required this.userName,
  });
  factory UserData.fromJson(final Map<String, dynamic> data) =>
      _$UserDataFromJson(data);

  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "userName")
  String userName;

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
