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
    tabBarTheme: const TabBarTheme(
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
     floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Coolors.greenDark,
      foregroundColor: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
        iconColor: Coolors.greyDark,
        tileColor: Coolors.backgroundDark),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey; // Thumb color when the switch is disabled
        }
        return Coolors.greyDark; // Thumb color when the switch is enabled
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors
              .grey.shade400; // Track color when the switch is disabled
        }
        return const Color(0xFF344047); // Track color when the switch is enabled
      }),
    ),
  );
}
