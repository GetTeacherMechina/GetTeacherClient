import "package:json_annotation/json_annotation.dart";

part "forgot_password_net_model.g.dart";

@JsonSerializable()
class ForgotPasswordModelRequest {
  ForgotPasswordModelRequest({required this.email});

  Map<String, dynamic> toJson() => _$ForgotPasswordModelRequestToJson(this);

  final String email;
}


@JsonSerializable()
class ForgotPasswordModelRespons {
  ForgotPasswordModelRespons({required this.token});
  factory ForgotPasswordModelRespons.fromJson(
    final Map<String, dynamic> json,
  ) => 
    _$ForgotPasswordModelResponsFromJson(json);

  final String token;
}
