import "dart:convert";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

const int debugPort = 44300;
const String baseUrl = "/api/v1";

final GetTeacherClient _client = GetTeacherClient();

GetTeacherClient getClient() => _client;

Uri httpUri(final String path) {
  if (kDebugMode) {
    return Uri.https("localhost:$debugPort", baseUrl + path);
  } else {
    throw Exception("No release url");
  }
}

Uri wsUri(final String path) {
  if (kDebugMode) {
    return Uri(
      scheme: "wss",
      host: "localhost",
      port: debugPort,
      path: baseUrl + path,
    );
  } else {
    throw Exception("No release url");
  }
}

class GetTeacherClient {
  final http.Client _client = http.Client();
  String? _jwt;

  void authorize(final String jwt) {
    _jwt = jwt;
  }

  void unauthorize() {
    _jwt = null;
  }

  String? jwt() => _jwt;

  Map<String, String> headers() => <String, String>{
        HttpHeaders.contentTypeHeader: "application/json",
        if (_jwt != null) HttpHeaders.authorizationHeader: "Bearer ${_jwt!}",
      };

  Map<String, dynamic> handleResponse(final http.Response response) {
    if (response.statusCode != 200) {
      throw Exception("Request failed with code: ${response.statusCode}");
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getJson(final String endpoint) async {
    final http.Response response =
        await _client.get(httpUri(endpoint), headers: headers());
    return handleResponse(response);
  }

  Future<Map<String, dynamic>> postJson(
    final String endpoint,
    final Map<String, dynamic> json,
  ) async {
    final http.Response response = await _client.post(
      httpUri(endpoint),
      headers: headers(),
      body: jsonEncode(json),
    );
    return handleResponse(response);
  }
}

Widget errorText(final Object object) => Text("Error occured: $object");
Widget noData() => const Text("No data");
Widget waiting() => const Center(
      child: CircularProgressIndicator(),
    );

extension MapSnapshot<T> on AsyncSnapshot<T> {
  Widget mapSnapshot<V>({
    required final Widget Function(T) onSuccess,
    final Widget Function() onWaiting = waiting,
    final Widget Function() onNoData = noData,
    final Widget Function(Object) onError = errorText,
  }) =>
      hasError
          ? onError(error!)
          : (ConnectionState.waiting == connectionState
              ? onWaiting()
              : (hasData ? onSuccess(data as T) : onNoData()));
}
