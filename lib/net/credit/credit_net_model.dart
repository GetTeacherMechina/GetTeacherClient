import "package:json_annotation/json_annotation.dart";

part "credit_net_model.g.dart";

@JsonSerializable()
class CreditRequestModel {
  const CreditRequestModel({
    required this.creditsDetails,
  });

  factory CreditRequestModel.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$CreditRequestModelFromJson(json);

  final List<CreditDetail> creditsDetails;
}

@JsonSerializable()
class CreditDetail {
  const CreditDetail({
    required this.description,
    required this.creditAmount,
    required this.priceInDollars,
  });

  final String description;
  final double creditAmount;
  final double priceInDollars;
}