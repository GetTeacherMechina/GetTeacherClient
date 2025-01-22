import "package:getteacher/views/credit_screen/credit_model.dart";
import "package:getteacher/net/net.dart";

Future<ItemPricesResponseModel> getCreditsResponseModel() async =>
    ItemPricesResponseModel.fromJson(
        (await getClient().getJson("/payment/credits")));

Future<ItemBuyResponseModel> buyCreditsProd(BuyItemRequestModel item) async =>
    ItemBuyResponseModel.fromJson(
        await getClient().postJson("/payment/credits/buy", item.toJson()));

Future<ItemBuyResponseModel> buyCreditsDev(BuyItemRequestModel item) async =>
    ItemBuyResponseModel.fromJson(
        await getClient().postJson("/payment/credits/dev-buy", item.toJson()));
