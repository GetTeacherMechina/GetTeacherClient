import "package:getteacher/views/credit_screen/credit_model.dart";
import "package:getteacher/net/net.dart";

Future<ItemPricesResponseModel> getCreditResponseModel() async =>
    ItemPricesResponseModel.fromJson(
        (await getClient().getJson("/payment/credits")));
