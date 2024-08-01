import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    scaffoldBackgroundColor: Coolors.backgroundDark,
    canvasColor: Coolors.backgroundDark,
    extensions: [
      CustomThemeExtension.darkMode
    ],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Coolors.greenDark,
              foregroundColor: Coolors.backgroundDark,
              splashFactory: NoSplash.splashFactory,
              elevation: 0,
              shadowColor: Colors.transparent
      )
    )
     // Use canvasColor for general background color
  );
}
