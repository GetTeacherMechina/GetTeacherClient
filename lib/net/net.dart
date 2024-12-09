import "dart:convert";

import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;

const int debugPort = 5205;

final GetTeacherClient _client = GetTeacherClient();

GetTeacherClient getClient() => _client;

Uri uriOfEndpoint(final String path) {
  if (kDebugMode) {
    return Uri.http("localhost:$debugPort", path);
  } else {
    throw Exception("No release url");
  }
}

class GetTeacherClient extends http.BaseClient {
  http.Client client = http.Client();
  @override
  Future<http.StreamedResponse> send(final http.BaseRequest request) =>
      client.send(request);

  Future<Map<String, dynamic>> getJson(final String endpoint) async {
    final http.Response response = await get(uriOfEndpoint(endpoint));
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
