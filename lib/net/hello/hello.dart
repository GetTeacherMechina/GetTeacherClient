import "package:getteacher/net/net.dart";
import "package:json_annotation/json_annotation.dart";

part "hello.g.dart";

@JsonSerializable()
class Hello {
  const Hello(this.message);

  factory Hello.fromJson(final Map<String, dynamic> json) =>
      _$HelloFromJson(json);

  final String message;
}

Future<Hello> fetchHello() async =>
    Hello.fromJson(await getClient().getJson("/hello"));
