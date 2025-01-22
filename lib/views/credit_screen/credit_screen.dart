import "package:flutter/material.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/views/credit_screen/credit_model.dart";
import "package:getteacher/net/credit/credit.dart";
import "package:getteacher/net/profile/profile.dart";

class CreditScreen extends StatefulWidget {
  const CreditScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  final Future<ItemPricesResponseModel> response = getCreditsResponseModel();

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Credits"),
          centerTitle: true,
        ),
        body: FutureBuilder<ItemPricesResponseModel>(
          future: response,
          builder: (
            final BuildContext context,
            final AsyncSnapshot<ItemPricesResponseModel> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              final itemPrices = snapshot.data!.itemPrices;

              return ListView.builder(
                itemCount: itemPrices.length,
                itemBuilder: (context, index) {
                  final item = itemPrices[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4.0,
                      child: ListTile(
                        title: Text(item.description),
                        subtitle: Text(
                          "Amount: ${item.amount}\nPrice: \$${item.priceInDollars.toStringAsFixed(2)}",
                        ),
                        trailing: Text(
                          "ID: ${item.itemId}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          _buyItem(context, item);
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("No data available."),
              );
            }
          },
        ),
      );

  void _buyItem(BuildContext context, PaymentItemDescriptor item) {
    showDialog(
      context: context,
      builder: (final BuildContext context) => AlertDialog(
        title: const Text("Item Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description: ${item.description}"),
            const SizedBox(height: 8),
            Text("Amount: ${item.amount}"),
            const SizedBox(height: 8),
            Text("Price: \$${item.priceInDollars.toStringAsFixed(2)}"),
            const SizedBox(height: 8),
            Text("Item ID: ${item.itemId}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              _confirmPurchase(item);
              Navigator.of(context).pop();
            },
            child: const Text("Buy"),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmPurchase(final PaymentItemDescriptor item) async =>
      buyCreditsDev(BuyItemRequestModel(item: item));
}
