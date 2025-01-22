
import "package:getteacher/net/credit/credit_net_model.dart";
import "package:getteacher/net/net.dart";

Future<CreditRequestModel> getCreditRsponsModel() async =>
  CreditRequestModel.fromJson((await getClient().getJson("/payment/credit-prices")));