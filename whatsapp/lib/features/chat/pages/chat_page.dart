import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/helpers/lastSceneMessage.dart';
import 'package:whatsapp/common/models/user_model.dart';
import 'package:whatsapp/common/routes/routes.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';
import 'package:whatsapp/features/auth/controllers/auth_controller.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            borderRadius: BorderRadius.circular(20),
            child: Row(children: [
              Icon(Icons.arrow_back_ios_new),
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
                    user.username,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'last scene 2 min ago',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  StreamBuilder(
                      stream: ref
                          .read(authControllerProvider)
                          .getUserPresenceStatus(uid: user.uid),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState !=
                            ConnectionState.active) {
                          return Text(
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
                            style:
                                TextStyle(fontSize: 12, color: Colors.white));
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
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 52,
                )
              ],
            ),
          ],
        ));
  }
}
