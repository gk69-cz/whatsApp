import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    scaffoldBackgroundColor: Coolors.backgroundDark,
    canvasColor: Coolors.backgroundDark,
    extensions: [CustomThemeExtension.darkMode],
    appBarTheme: const AppBarTheme(
        backgroundColor: Coolors.greyBackground,
        titleTextStyle: TextStyle(fontSize: 18),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light),
        iconTheme: IconThemeData(color: Coolors.greyDark)),
    tabBarTheme: TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Coolors.greenDark, width: 2.0),
      ),
      unselectedLabelColor: Coolors.greyDark,
      labelColor: Coolors.greenDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Coolors.greenDark,
            foregroundColor: Coolors.backgroundDark,
            splashFactory: NoSplash.splashFactory,
            elevation: 0,
            shadowColor: Colors.transparent)),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Coolors.greyBackground,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ))),
    dialogBackgroundColor: Coolors.greyBackground,
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
