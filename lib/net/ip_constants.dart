import "package:flutter/foundation.dart";

const int debugPort = 80;
const String baseUrl = "/api/v1";

const String debugHost = "172.20.20.61";

Uri httpUri(final String path) {
  if (kDebugMode) {
    return Uri.http("$debugHost:$debugPort", baseUrl + path);
  } else {
    throw Exception("No release url");
  }
}

Uri wsUri(final String path) {
  if (kDebugMode) {
    return Uri(
      scheme: "ws",
      host: debugHost,
      port: debugPort,
      path: baseUrl + path,
    );
  } else {
    throw Exception("No release url");
  }
}
