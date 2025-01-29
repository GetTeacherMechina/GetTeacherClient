import "package:flutter/material.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/profile/profile.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/views/credit_screen/credit_screen.dart";

class CreditButton extends StatefulWidget {
  const CreditButton({
    super.key,
    this.onExit,
  });
  final void Function()? onExit;

  @override
  State<CreditButton> createState() => _CreditButtonState();
}

class _CreditButtonState extends State<CreditButton> {
  Future<double>? creditsFuture;
  @override
  void initState() {
    super.initState();
    creditsFuture = profile().then((final ProfileResponseModel p) => p.credits);
  }

  @override
  void didUpdateWidget(covariant final CreditButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    creditsFuture =
        profile().then((final ProfileResponseModel value) => value.credits);
  }

  @override
  Widget build(final BuildContext context) => FutureBuilder<double>(
        future: creditsFuture,
        builder: (
          final BuildContext context,
          final AsyncSnapshot<double> snapshot,
        ) =>
            snapshot.mapSnapshot(
          onSuccess: (final double credits) => GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (final BuildContext context) => const CreditScreen(),
                ),
              );
              widget.onExit?.call();
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.credit_score, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    "Credits: ${credits.toInt()}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
