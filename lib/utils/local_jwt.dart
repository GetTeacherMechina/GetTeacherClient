import "package:shared_preferences/shared_preferences.dart";

class LocalJwt {
  static Future<String?> getLocalJwt() =>
      SharedPreferencesAsync().getString("local_jwt");
  static void setLocalJwt(final String jwt) =>
      SharedPreferencesAsync().setString("local_jwt", jwt );
}
