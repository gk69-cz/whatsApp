import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/helpers/lastSceneMessage.dart';
import 'package:whatsapp/common/models/user_model.dart';
import 'package:whatsapp/common/routes/routes.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';
import 'package:whatsapp/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/features/chat/widget/chat_text_field.dart';

String getMinutesAndSeconds(DateTime dateTime) {
  // Extract minutes and seconds
  int minutes = dateTime.minute;
  int seconds = dateTime.second;

  // Format them as a string with leading zeros if needed
  String formattedMinutes = minutes.toString().padLeft(2, '0');
  String formattedSeconds = seconds.toString().padLeft(2, '0');

  return '$formattedMinutes:$formattedSeconds';
}
class ChatPage extends ConsumerWidget {
  const ChatPage({super.key, required this.user});
  final UserModel user;
 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: context.theme.chatPageBgColor,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            borderRadius: BorderRadius.circular(20),
            child: Row(children: [
              const Icon(Icons.arrow_back_ios_new),
              Hero(
                tag: 'profile',
                child: Container(
                  width: 32,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              user.profileImageUrl))),
                ),
              )
            ]),
          ),
          title: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.profile, arguments: user);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'last seen ${lastSceneMessage(user.lastScene)} ago',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  StreamBuilder(
                      stream: ref
                          .read(authControllerProvider)
                          .getUserPresenceStatus(uid: user.uid),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState !=
                            ConnectionState.active) {
                          return const Text(
                            'connecting',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          );
                        }
                        final singleUserModel = snapshot.data!;

                        final lastMessage =
                            lastSceneMessage(singleUserModel.lastScene);
                        return Text(
                            singleUserModel.active
                                ? 'Online'
                                : '$lastMessage ago',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white));
                      }),
                ],
              ),
            ),
          ),
          actions: [
            custom_icon_button(
              onTap: () {},
              icon: Icons.video_call,
            ),
            custom_icon_button(
              onTap: () {},
              icon: Icons.call,
            ),
            custom_icon_button(
              onTap: () {},
              icon: Icons.more_vert,
            )
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: ref
                        .watch(chatControllerProvider)
                        .getAllOneToOneMessage(user.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.active) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            final message = snapshot.data![index];
                            final isSender = message.senderId ==
                                FirebaseAuth.instance.currentUser!.uid;

                            final haveNip = (index == 0) ||
                                (index == snapshot.data!.length - 1 &&
                                    message.senderId !=
                                        snapshot.data![index - 1].senderId) ||
                                (message.senderId !=
                                        snapshot.data![index - 1].senderId &&
                                    message.senderId ==
                                        snapshot.data![index + 1].senderId) ||
                                (message.senderId !=
                                        snapshot.data![index - 1].senderId &&
                                    message.senderId !=
                                        snapshot.data![index + 1].senderId);
                            final isShowDateCard = (index == 0) ||
                                ((index == snapshot.data!.length - 1) &&
                                    (message.timeSent.day >
                                        snapshot
                                            .data![index - 1].timeSent.day)) ||
                                (message.timeSent.day >
                                        snapshot
                                            .data![index - 1].timeSent.day &&
                                    message.timeSent.day <=
                                        snapshot.data![index + 1].timeSent.day);
                            return Column(

                              children: [
if(index == 0)
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    margin: EdgeInsets.symmetric(
      vertical: 10,
      horizontal:30
    ),
    padding: EdgeInsets.all(10.0),
  decoration: BoxDecoration(
    color: Colors.amber,
    borderRadius: BorderRadius.circular(10)
  ),
  child: Text(
    'messages are securesd', style: TextStyle(
      fontSize: 13,
    ),
  ),
  ),
),
                                    Container(                           
                                    alignment: isSender
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        top: 4, 
                                        bottom: 4,
                                         left: isSender ? 80 : haveNip ? 15: 10,
                                        right: isSender ? haveNip ? 10: 15: 80 ,
                                       ),
                                    child: ClipPath(
                                      clipper: haveNip ? UpperNipMessageClipperTwo(
                                          isSender
                                              ? MessageType.send
                                              : MessageType.receive,
                                          nipHeight: 10,
                                          bubbleRadius: haveNip ? 15 :10,
                                          nipWidth: 8): null,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isSender
                                              ? context.theme.senderChatBg
                                              : context.theme.recieverChatBg,
                                    
                                              borderRadius: haveNip ? null : BorderRadius.circular(12)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              left: isSender ? 10 : 15,
                                              right: isSender ? 15 : 10),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom:9.0),
                                                child: Text(
                                                  message.textMessage,style: TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                          
                                            child: Text(getMinutesAndSeconds(message.timeSent as DateTime),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: context.theme.greyColor
                                              ),
                                            ),
                                               )                                          ],
                                          ),
                                        ),
                                      ),
                                    )),
                                  ],
                            );
                          });
                    },
                  ),
                ),
                ChatTextField(recieverId: user.uid)
              ],
            ),
          ],
        ));
  }
}
