import "package:json_annotation/json_annotation.dart";

part "forgot_password_net_model.g.dart";

@JsonSerializable()
class ForgotPasswordRequestModel {
  ForgotPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestModelToJson(this);

  final String email;
}


@JsonSerializable()
class ForgotPasswordResponseModel {
  ForgotPasswordResponseModel();
  factory ForgotPasswordResponseModel.fromJson(
    final Map<String, dynamic> json,
  ) => 
    _$ForgotPasswordResponseModelFromJson(json);
}
