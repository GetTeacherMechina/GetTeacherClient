import "package:json_annotation/json_annotation.dart";

part "reset_password_net_model.g.dart";

@JsonSerializable()
class ResetPasswordResponseModel {
  const ResetPasswordResponseModel({
    required this.email,
    required this.code,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordResponseModelToJson(this);

  final String email;
  final String code;
  final String password;
  final String confirmPassword;
}
