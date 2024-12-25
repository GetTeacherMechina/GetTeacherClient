import "dart:convert";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

const int debugPort = 5000;//44300;
const String baseUrl = "/api/v1";

final GetTeacherClient _client = GetTeacherClient();

GetTeacherClient getClient() => _client;

Uri uriOfEndpoint(final String path) {
  if (kDebugMode) {
    return Uri.http("localhost:$debugPort", path);
  } else {
    throw Exception("No release url");
  }
}

class GetTeacherClient {
  final http.Client _client = http.Client();
  String? _jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1lY2hpbmEtaGFuaWNoLTI0QGdyZWVuZHJlYW10ZWFtLm9ubWljcm9zb2Z0LmNvbSIsInN1YiI6IjEiLCJqdGkiOiJmMzBjZDRhMy1iN2QwLTQ0YjUtYTEzNy1iNDA4NWQ5M2Y5ZjUiLCJleHAiOjE3MzUxNTc0NDYsImlzcyI6Im1lIiwiYXVkIjoieW91In0.oOV2g74VSSnxKYtGTwhS8ZIqF7nnEUrlit_OQo47FFQ";

  void authorize(final String jwt) {
    _jwt = jwt;
  }

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
    final http.Response response = await _client
        .get(uriOfEndpoint(baseUrl + endpoint), headers: headers());
    return handleResponse(response);
  }

  Future<Map<String, dynamic>> postJson(
    final String endpoint,
    final Map<String, dynamic> json,
  ) async {
    final http.Response response = await _client.post(
      uriOfEndpoint(baseUrl + endpoint),
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
