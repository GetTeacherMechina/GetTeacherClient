class ResetMyPasswordModel {
  const ResetMyPasswordModel()
      : password = "",
        confirmPassword = "",
        code = "";

  const ResetMyPasswordModel._hidden(
      {required this.password,
      required this.confirmPassword,
      required this.code,});

  final String password;
  final String confirmPassword;
  final String code;

  ResetMyPasswordModel copyWith({
    final String Function()? password,
    final String Function()? confirmPassword,
    final String Function()? code,
  }) =>
      ResetMyPasswordModel._hidden(
        password: password != null ? password() : this.password,
        confirmPassword:
            confirmPassword != null ? confirmPassword() : this.confirmPassword,
        code: code != null ? code() : this.code,
      );
}
