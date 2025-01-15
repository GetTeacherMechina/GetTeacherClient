import "package:json_annotation/json_annotation.dart";

part "reset_password_net_model.g.dart";

@JsonSerializable()
class ResetPasswordResponsModle {
  const ResetPasswordResponsModle({
    required this.email,
    required this.token,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordResponsModleToJson(this);

  final String email;
  final String token;
  final String password;
  final String confirmPassword;
}