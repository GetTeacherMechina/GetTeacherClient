class ResetMyPasswordModel {
  const ResetMyPasswordModel()
      : password = "",
       confirmPassword = "";

  const ResetMyPasswordModel._hidden({
   required this.password, required this.confirmPassword
  });

  final String password;
  final String confirmPassword;

  ResetMyPasswordModel copyWith({
    final String Function()? password,
    final String Function()? confirmPassword,
  }) =>
      ResetMyPasswordModel._hidden(
        password: password != null ? password() : this.password,
        confirmPassword: confirmPassword != null ? confirmPassword() : this.confirmPassword,
      );
}
