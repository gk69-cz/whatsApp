import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/models/last_message.dart';
import 'package:whatsapp/common/routes/routes.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';

class ChatHomePage extends ConsumerWidget {
  const ChatHomePage({super.key});

  navigateToContactPage(context) {
    Navigator.pushNamed(context, Routes.contact);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: StreamBuilder<List<LastMessageModel>>(
            stream: ref.watch(chatControllerProvider).getAllLastMessageList(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Coolors.greenDark,
                  ),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No chats available'),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                final lastMessageData = snapshot.data![index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lastMessageData.userName),
                      Text(
                        lastMessageData.timeSent.toString(),
                        style: TextStyle(
                          fontSize: 13,
                          color: context.theme.greyColor,
                        ),
                      )
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      lastMessageData.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.theme.greyColor,
                      ),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      lastMessageData.profileImageUrl,
                    ),
                    radius: 24,
                  ),
                );
              });
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToContactPage(context),
          child: const Icon(Icons.chat),
        ));
  }
}
