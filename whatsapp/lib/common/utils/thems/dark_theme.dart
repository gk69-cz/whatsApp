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
      appBarTheme:const  AppBarTheme(
        titleTextStyle: TextStyle(fontSize: 18),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light
        )
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
          borderRadius: BorderRadius.all(Radius.circular(20)
          ),
        )),
      );
}
