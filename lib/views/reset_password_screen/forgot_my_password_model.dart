class ForgotMyPasswordModel {
  const ForgotMyPasswordModel() : email = "";

  const ForgotMyPasswordModel._hidden({
    required this.email,
  });

  final String email;

  ForgotMyPasswordModel copyWith({
    final String Function()? email,
  }) =>
      ForgotMyPasswordModel._hidden(
        email: email != null ? email() : this.email,
      );
}
