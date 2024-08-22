import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: Coolors.backgroundLight,
    canvasColor: Coolors.backgroundLight,
    extensions: [CustomThemeExtension.lightMode],
    appBarTheme: const AppBarTheme(
        backgroundColor: Coolors.greenLight,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark),
        iconTheme: IconThemeData(color: Colors.white)),
    tabBarTheme: TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      unselectedLabelColor: Color(0xFF83D9D2),
      labelColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Coolors.greenLight,
            foregroundColor: Coolors.backgroundLight,
            splashFactory: NoSplash.splashFactory,
            elevation: 0,
            shadowColor: Colors.white)),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Coolors.backgroundLight,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ))),
    dialogBackgroundColor: Coolors.backgroundLight,
    dialogTheme: const DialogTheme(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Coolors.greenDark,
      foregroundColor: Colors.white,
    ),
  );
}
