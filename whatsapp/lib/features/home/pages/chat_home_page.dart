import 'package:flutter/material.dart';
import 'package:whatsapp/common/routes/routes.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});

  navigateToContactPage(context){
    Navigator.pushNamed(context, Routes.contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
          child: Text('chat home page'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToContactPage(context),
          child: const Icon(Icons.chat),
        ));
  }
}
