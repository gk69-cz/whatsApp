import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';
import 'package:whatsapp/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp/features/home/pages/call_home_page.dart';
import 'package:whatsapp/features/home/pages/chat_home_page.dart';
import 'package:whatsapp/features/home/pages/status_home_page.dart';

class HomePage extends ConsumerStatefulWidget {

  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

    late Timer timer;
  
updateUserPresence(){
ref.read(authControllerProvider).updateUserPresence();
}
@override
  void initState() {
  updateUserPresence();
    timer = Timer.periodic(
      const Duration(minutes: 1), 
      (timer) => setState(() {

    }),);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp',style: TextStyle(
          letterSpacing: 1
        ),),
        elevation:1,
        actions: [
          custom_icon_button(onTap: (){},icon: Icons.search,),
          custom_icon_button(onTap: (){},icon: Icons.more_vert,)
        ],
        bottom: const TabBar(
          indicatorWeight: 3,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          splashFactory: NoSplash.splashFactory,
          tabs: [          
          Tab(text:'Chats'),
          Tab(text:'Status'),
          Tab(text:'Calls'),
        ]),
        ),
        body: const TabBarView(children: [
          ChatHomePage(),
          StatusHomePage(),
          CallHomePage()
        ]),
        
      )
      
    );
  }
}