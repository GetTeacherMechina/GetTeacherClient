import "package:flutter/material.dart";

class AppTheme {
  // Primary colors
  static const Color primaryColor = Colors.deepPurple;
  static const Color accentColor = Colors.deepPurpleAccent;

  // Text colors
  static const Color textColor = Colors.black87;
  static const Color secondaryTextColor = Colors.black54;
  static const Color hintTextColor = Colors.grey;
  static const Color linkColor = Colors.deepPurple;

  // Background colors
  static const Color backgroundColor = Color(0xFFf5f5f5);
  static Color inputFieldBackground = Colors.blueGrey[50]!;
  static const Color whiteColor = Colors.white;

  // Button Background Colors
  static const Color defaultButtonBack = Colors.white;

  // Border colors
  static const Color borderColor = Colors.grey;

  static const Color appBarTextColor = Colors.white;

  // Shadow settings
  static final BoxShadow defaultShadow = BoxShadow(
    color: Colors.grey.withAlpha((0.2 * 255).toInt()),
    spreadRadius: 10,
    blurRadius: 12,
    offset: const Offset(0, 3),
  );

  static final BoxShadow purpleShadow = BoxShadow(
    color: Colors.deepPurple.withAlpha((0.4 * 255).toInt()),
    spreadRadius: 5,
    blurRadius: 15,
  );

  // Text styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  // Text styles
  static const TextStyle appBarTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: appBarTextColor,
  );

  static const TextStyle secondaryHeadingStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: textColor,
  );

    static const TextStyle secondaryTextStyle = TextStyle(
    fontSize: 16,
    color: hintTextColor,
  );

  static const TextStyle matchTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: linkColor,
  );

}
