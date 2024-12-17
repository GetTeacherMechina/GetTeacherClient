import "package:getteacher/net/login/login_net_model.dart";

class LoginModel {
  const LoginModel()
      : email = "",
        password = "";

  const LoginModel._hidden({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  LoginModel copyWith({
    final String Function()? email,
    final String Function()? password,
  }) =>
      LoginModel._hidden(
        email: email != null ? email() : this.email,
        password: password != null ? password() : this.password,
      );

  LoginRequestModel toRequest() =>
      LoginRequestModel(email: email, password: password);
}
