class ForgotMyPasswordCodeModel {
  const ForgotMyPasswordCodeModel()
      : code = "";

  const ForgotMyPasswordCodeModel._hidden({
    required this.code,
  });

  final String code;

  ForgotMyPasswordCodeModel copyWith({
    final String Function()? code,
  }) =>
      ForgotMyPasswordCodeModel._hidden(
        code: code != null ? code() : this.code,
      );
}
