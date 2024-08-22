import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/routes/routes.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/utils/thems/dark_theme.dart';
import 'package:whatsapp/common/utils/thems/light_theme.dart';
import 'package:whatsapp/features/auth/repository/auth_repository.dart';
import 'package:whatsapp/features/contract/pages/contact_page.dart';
import 'package:whatsapp/features/home/pages/home_page.dart';
import 'package:whatsapp/features/welcome/pages/welcome_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Whats App Clone',
      theme: lightTheme(), // Assuming you have a lightTheme() function
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
home: ContactPage(),
    //  home: ref.watch(userInfoAuthProvider).when(
    //     data: (user){
    //      if(user == null) return  WelcomePage();
    //     return HomePage();
    //   }, error: (error,trace){
    //     return const Scaffold(
    //       body: Center(
    //         child: Text('Scomething went wrong'),)
    //     ); 
    //     }, loading: (){
    //       return SafeArea(
    //         child: Scaffold(
    //           body: Center(
    //             child: Icon(
    //               Icons.whatshot_sharp,
    //               size: 30,
    //               color: Colors.black26,
    //             ),
    //           ),
    //         ),
    //       );
    //     }),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}