import 'package:flutter/material.dart';
import "package:getteacher/theme/theme.dart";

class AppWidgets {
    static InputDecoration inputDecoration({
  required final String hint,
  final bool obscureText = false, 
  final bool passField = false,
  final VoidCallback? onTap,  
}) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: AppTheme.inputFieldBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    hintStyle: const TextStyle(color: AppTheme.hintTextColor),
    suffixIcon: passField
        ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppTheme.hintTextColor,
            ),
            onPressed: onTap,
          )
        : null,
  );

  static Positioned logoImage() => Positioned(
            top: 5,
            right: 5,
            child: Image.asset(
              "assets/images/logo1.png",
              width: 190,
            ),
          );

  static Positioned fadedBigLogo() => Positioned(
      bottom: -6,
      right: -6,
      child: Opacity(
        opacity: 0.3,
        child: Image.asset(
          "assets/images/logo1.png",
          width: 384,
          height: 384,
        ),
      ),
    );

  static Positioned bubblesImage() => Positioned(
      top: 5,
      left: 5,
      child: Opacity(
        opacity: 0.3,
        child: Image.asset(
          "assets/images/bubbles.png",
          width: 1536,
          height: 960,
        ),
      ),
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