import "package:flutter/material.dart";

class ImageDisplayer extends StatelessWidget {
  const ImageDisplayer({super.key, required this.url});
  final String url;
  @override
  Widget build(final BuildContext context) => Hero(
        tag: url,
        child: Image(
          image: NetworkImage(url),
          width: 100,
        ),
      );
}
