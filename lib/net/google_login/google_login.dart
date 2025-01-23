import "package:getteacher/net/google_login/google_login_net_model.dart";
import "package:getteacher/net/net.dart";
import "package:google_sign_in/google_sign_in.dart";


Future<void> googleLogin() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    if (googleAuth.idToken == null) {
      return;
    }
    await getClient().postJson("/auth/google", GoogleLoginNetModelResponse(idToken: googleAuth.idToken!).toJson());

  } catch (e) {
      print("Error signing in: $e");
    }
}