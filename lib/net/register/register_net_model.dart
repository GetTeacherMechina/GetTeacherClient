import "package:json_annotation/json_annotation.dart";

part "register_net_model.g.dart";

@JsonSerializable()
class RegisterRequestModel {
  RegisterRequestModel({
    required this.fullName,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);

  @JsonKey(name: "FullName")
  final String fullName;
  @JsonKey(name: "Password")
  final String password;
  @JsonKey(name: "Email")
  final String email;
}
