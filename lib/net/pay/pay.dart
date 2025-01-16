import "package:getteacher/net/net.dart";
import "package:getteacher/net/pay/pay_net_model.dart";

Future<PayResponseModel> pay(final PayRequsetModel model) async {
  final Map<String, dynamic> json =
      await getClient().postJson("/pay", model.toJson());
  return PayResponseModel.fromJson(json);
}
