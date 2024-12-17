import "package:json_annotation/json_annotation.dart";

part "login_net_model.g.dart";

@JsonSerializable()
class LoginRequestModel {
  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);

  @JsonKey(name: "Email")
  final String email;

  @JsonKey(name: "Password")
  final String password;
}

@JsonSerializable()
class LoginResponseModel {
  const LoginResponseModel({
    required this.jwtToken,
  });

  factory LoginResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  final String jwtToken;
}
