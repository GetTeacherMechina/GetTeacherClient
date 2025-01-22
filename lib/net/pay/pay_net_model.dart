import "package:json_annotation/json_annotation.dart";

part "pay_net_model.g.dart";

@JsonSerializable()
class PayResponseModel {
  PayResponseModel({
    required this.clientSecret,
  });

  factory PayResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$PayResponseModelFromJson(json);

  final String clientSecret;
}

@JsonSerializable()
class PayRequsetModel {
  const PayRequsetModel({
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() => _$PayRequsetModelToJson(this);

  final int amount;
  final String currency;
}
