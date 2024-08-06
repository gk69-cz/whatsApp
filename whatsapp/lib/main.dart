import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/thems/dark_theme.dart';
import 'package:whatsapp/common/utils/thems/light_theme.dart';
import 'package:whatsapp/features/auth/pages/user_info_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whats App Clone',
      theme: lightTheme(), // Assuming you have a lightTheme() function
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const UserInfoPage(),
    );
  }
}