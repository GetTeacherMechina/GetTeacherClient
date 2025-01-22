import "package:json_annotation/json_annotation.dart";

part "credit_model.g.dart";

@JsonSerializable()
class PaymentItemDescriptor {
  PaymentItemDescriptor({
    required this.itemId,
    required this.description,
    required this.amount,
    required this.priceInDollars,
  });

  factory PaymentItemDescriptor.fromJson(final Map<String, dynamic> json) =>
      _$PaymentItemDescriptorFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentItemDescriptorToJson(this);

  final int itemId;
  final String description;
  final double amount;
  final double priceInDollars;
}

@JsonSerializable()
class ItemPricesResponseModel {
  ItemPricesResponseModel({
    required this.itemPrices,
  });

  factory ItemPricesResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$ItemPricesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemPricesResponseModelToJson(this);

  final List<PaymentItemDescriptor> itemPrices;
}

@JsonSerializable()
class BuyItemRequestModel {
  BuyItemRequestModel({
    required this.item,
  });

  Map<String, dynamic> toJson() => _$BuyItemRequestModelToJson(this);

  final PaymentItemDescriptor item;
}

@JsonSerializable()
class ItemBuyResponseModel {
  ItemBuyResponseModel({
    required this.statusCode,
  });

  factory ItemBuyResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$ItemBuyResponseModelFromJson(json);

  final String statusCode;
}
