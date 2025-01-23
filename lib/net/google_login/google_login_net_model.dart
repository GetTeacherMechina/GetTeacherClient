import "package:json_annotation/json_annotation.dart";

part "google_login_net_model.g.dart";

@JsonSerializable()
class GoogleLoginNetModelResponse {
  GoogleLoginNetModelResponse({required this.idToken});

  Map<String, dynamic> toJson() => _$GoogleLoginNetModelResponseToJson(this);

  final String idToken;
}