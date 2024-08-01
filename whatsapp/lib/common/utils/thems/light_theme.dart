import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      scaffoldBackgroundColor: Coolors.backgroundLight,
      canvasColor: Coolors.backgroundLight,
      extensions: [CustomThemeExtension.lightMode],
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Coolors.greenLight,
              foregroundColor: Coolors.backgroundLight,
              splashFactory: NoSplash.splashFactory,
              elevation: 0,
              shadowColor: Colors.white)));
}
