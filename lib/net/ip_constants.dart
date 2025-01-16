import "package:flutter/foundation.dart";

const int debugPort = 443;
const String baseUrl = "/api/v1";

const String debugHost = "172.20.20.49";

Uri httpUri(final String path) {
  if (kDebugMode) {
    return Uri.https("$debugHost:$debugPort", baseUrl + path);
  } else {
    throw Exception("No release url");
  }
}

Uri wsUri(final String path) {
  if (kDebugMode) {
    return Uri(
      scheme: "wss",
      host: debugHost,
      port: debugPort,
      path: baseUrl + path,
    );
  } else {
    throw Exception("No release url");
  }
}
