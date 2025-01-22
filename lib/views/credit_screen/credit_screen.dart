import "package:flutter/material.dart";
import "package:getteacher/net/credit/credit.dart";
import "package:getteacher/net/credit/credit_net_model.dart";
import "package:getteacher/net/net.dart";

class CreditScreen extends StatefulWidget {
  CreditScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreditScreen();
}

class _CreditScreen extends State<CreditScreen> {
  final Future<CreditRequestModel> response = getCreditRsponsModel();

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: FutureBuilder<CreditRequestModel>(
          future: response,
          builder: (
            final BuildContext context,
            final AsyncSnapshot<CreditRequestModel> snapshot,
          ) =>
              snapshot.mapSnapshot(
            onSuccess: (final CreditRequestModel response) => Center(
              child: Column(
                children: response.creditsDetails
                    .map(
                      (final CreditDetail c) => Row(
                        children: [
                          Text(
                            c.description,
                          ),
                          const Spacer(
                            flex: 4,
                          ),
                          Text(
                            c.creditAmount.toString(),
                          ),
                          const Spacer(
                            flex: 4,
                          ),
                          Text(
                            c.priceInDollars.toString(),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      );
}
