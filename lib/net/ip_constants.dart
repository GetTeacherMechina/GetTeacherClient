import "package:flutter/foundation.dart";

const int debugPort = 80;
const String baseUrl = "/api/v1";

const String debugHost = "127.0.0.1";

Uri httpUri(final String path) {
  return Uri.http("$debugHost:$debugPort", baseUrl + path);
}

Uri wsUri(final String path) {
  return Uri(
    scheme: "ws",
    host: debugHost,
    port: debugPort,
    path: baseUrl + path,
  );
}
