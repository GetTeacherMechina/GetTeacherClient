import "dart:convert";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;

const int debugPort = 44300;
const String baseUrl = "/api/v1";

final GetTeacherClient _client = GetTeacherClient();

GetTeacherClient getClient() => _client;

Uri uriOfEndpoint(final String path) {
  if (kDebugMode) {
    return Uri.https("localhost:$debugPort", path);
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
    final http.Response response = await get(uriOfEndpoint(baseUrl + endpoint));
    if (response.statusCode != 200) {
      throw Exception("Request failed with code: ${response.statusCode}");
    }
    print(response.body);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> postJson(
    final String endpoint,
    final Map<String, dynamic> json,
  ) async {
    final http.Response response = await post(
      uriOfEndpoint(baseUrl + endpoint),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode(json),
    );

    if (response.statusCode != 200) {
      throw Exception(
          "Request failed with code: ${response.statusCode} ${response.body}");
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
