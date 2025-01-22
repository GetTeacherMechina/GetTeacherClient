import "package:flutter/material.dart";
import "package:latext/latext.dart";

class LatexTextWidget extends StatelessWidget {
  const LatexTextWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(final BuildContext context) => LaTexT(
          laTeXCode: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ));
}
