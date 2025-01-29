import "package:flutter/material.dart";
import "package:getteacher/net/ip_constants.dart";

class ImageDisplayer extends StatelessWidget {
  const ImageDisplayer({super.key, required this.url});
  final String url;

  @override
  Widget build(final BuildContext context) => Hero(
        tag: url,
        child: SizedBox(
          width: 200,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder<void>(
                    pageBuilder:
                        (final BuildContext context, final _, final __) =>
                            GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Scaffold(
                        body: Center(
                          child: Hero(
                            tag: url,
                            child: Image.network(
                              httpUri(url).toString(),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Image.network(
                httpUri(url).toString(),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      );
}
