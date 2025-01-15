import "package:json_annotation/json_annotation.dart";

part "code_check_net_model.g.dart";

@JsonSerializable()
class ResetPasswordCodeRequstModel {
  ResetPasswordCodeRequstModel({required this.code, required this.token});

  Map<String, dynamic> toJson() => _$ResetPasswordCodeRequstModelToJson(this);

  final String code;
  final String token;
}
