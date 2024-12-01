class Model {
  const Model() : i = 0;

  const Model._hidden({required this.i});

  final int i;

  Model _copyWith({final int Function()? i}) =>
      Model._hidden(i: i == null ? this.i : i());

  Model incrementI() => _copyWith(i: () => i + 1);
}
