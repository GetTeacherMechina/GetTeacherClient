import 'package:flutter/material.dart';

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

  // Shadow settings
  static final BoxShadow defaultShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 10,
    blurRadius: 12,
    offset: const Offset(0, 3),
  );

  static final BoxShadow purpleShadow = BoxShadow(
    color: Colors.deepPurple.withOpacity(0.4),
    spreadRadius: 5,
    blurRadius: 15,
  );

  // Text styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: linkColor,
  );

  static InputDecoration inputDecoration({
  required final String hint,
  final bool obscureText = false, 
  final bool passField = false,
  final VoidCallback? onTap,  
}) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: inputFieldBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    hintStyle: const TextStyle(color: hintTextColor),
    suffixIcon: passField
        ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: hintTextColor,
            ),
            onPressed: onTap,
          )
        : null,
  );

  static Widget menuItem({required final String title, final bool isActive = false}) => Padding(
        padding: const EdgeInsets.only(right: 75),
        child: MouseRegion(
          cursor: isActive ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? AppTheme.linkColor : AppTheme.hintTextColor,
            ),
          ),
        ),
      );
}