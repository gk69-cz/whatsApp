import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/routes/routes.dart';
import 'package:whatsapp/common/utils/thems/dark_theme.dart';
import 'package:whatsapp/common/utils/thems/light_theme.dart';
import 'package:whatsapp/features/welcome/pages/welcome_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
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
      home: const WelcomePage(),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}