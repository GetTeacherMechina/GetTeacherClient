import "package:flutter/material.dart";
import "package:flutter_tex/flutter_tex.dart";

class LatexParserWidget extends StatelessWidget {
  const LatexParserWidget({required this.inputText, super.key});
  final String inputText;

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildTextWithLatex(inputText),
        ),
      );

  List<Widget> _buildTextWithLatex(final String text) {
    final RegExp regex = RegExp(r"\$\$(.+?)\$\$");
    final Iterable<RegExpMatch> matches = regex.allMatches(text);

    final List<Widget> widgets = <Widget>[];
    int lastMatchEnd = 0;

    for (final RegExpMatch match in matches) {
      // Add plain text before the LaTeX block
      if (match.start > lastMatchEnd) {
        widgets.add(
          Text(
            text.substring(lastMatchEnd, match.start),
            style: const TextStyle(fontSize: 16),
          ),
        );
      }

      // Add the LaTeX block
      final String latexContent = match.group(1) ?? "";
      widgets.add(
        TeXView(
          child: TeXViewDocument(r"$$" + latexContent + r"$$"),
          style: const TeXViewStyle(
            margin: TeXViewMargin.all(10),
          ),
        ),
      );

      lastMatchEnd = match.end;
    }

    // Add any remaining text after the last match
    if (lastMatchEnd < text.length) {
      widgets.add(
        Text(
          text.substring(lastMatchEnd),
          style: const TextStyle(fontSize: 16),
        ),
      );
    }

    return widgets;
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: LatexParserWidget(
              inputText:
                  "Text with LaTeX: \$\$x^2 + y^2 = z^2\$\$ and \$\$e^{i\\pi} + 1 = 0\$\$.",
            ),
          ),
        ),
      ),
    ),
  );
}
