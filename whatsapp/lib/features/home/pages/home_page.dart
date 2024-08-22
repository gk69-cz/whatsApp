import 'package:flutter/material.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';
import 'package:whatsapp/features/home/pages/call_home_page.dart';
import 'package:whatsapp/features/home/pages/chat_home_page.dart';
import 'package:whatsapp/features/home/pages/status_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
    child: Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp',style: TextStyle(
          letterSpacing: 1
        ),),
        elevation:1,
        actions: [
          custom_icon_button(onTap: (){},icon: Icons.search,),
          custom_icon_button(onTap: (){},icon: Icons.more_vert,)
        ],
        bottom: TabBar(
          indicatorWeight: 3,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          splashFactory: NoSplash.splashFactory,
          tabs: [          
          Tab(text:'Chats'),
          Tab(text:'Status'),
          Tab(text:'Calls'),
        ]),
        ),
        body: TabBarView(children: [
          ChatHomePage(),
          StatusHomePage(),
          CallHomePage()
        ]),
        
      )
      
    );
  }
}