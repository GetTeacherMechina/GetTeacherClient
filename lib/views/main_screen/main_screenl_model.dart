import "package:getteacher/net/hello/hello.dart";

class Model {
  const Model() : hello = const Hello("");

  const Model._hidden({required this.hello});

  final Hello hello;

  Model copyWith({final Hello Function()? hello}) =>
      Model._hidden(hello: hello == null ? this.hello : hello());
}
