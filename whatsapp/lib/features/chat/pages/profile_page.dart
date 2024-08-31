import 'package:flutter/material.dart';
import 'package:whatsapp/common/helpers/lastSceneMessage.dart';
import 'package:whatsapp/common/models/user_model.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';
import 'package:whatsapp/features/chat/widget/custom_list_title.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.profilePageBg,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverPersistentDelegate(user),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Text(
                        user.userName,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        user.phoneNumber,
                        style: TextStyle(
                            fontSize: 20, color: context.theme.greyColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "last seen ${lastSceneMessage(user.lastScene)} ago",
                        style: TextStyle(
                            fontSize: 14, color: context.theme.greyColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconWithText(icon: Icons.call, text: 'Call'),
                          iconWithText(icon: Icons.video_call, text: 'Video'),
                          iconWithText(icon: Icons.search, text: 'Search'),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 30.0),
                  title: const Text('Hey there! Iam using Whatsapp'),
                  subtitle: Text('17 February',
                      style: TextStyle(color: context.theme.greyColor)),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomListTitle(
                    title: 'Mute notification',
                    leading: Icons.notification_important,
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    )),
                const CustomListTitle(
                  title: 'Custom notification',
                  leading: Icons.music_note,
                ),
                CustomListTitle(
                  title: 'Media visiblity',
                  leading: Icons.photo,
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomListTitle(
                  title: 'Encryption',
                  leading: Icons.lock,
                  subtitle: 'Messages and calls are encrypted',
                ),
                const CustomListTitle(
                  title: 'Disappering message',
                  leading: Icons.timer,
                  subtitle: 'Off',
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: custom_icon_button(
                      onTap: () {},
                      icon: Icons.group,
                      background: Coolors.greenDark,
                      color: Colors.white),
                  title: Text('Create group with ${user.userName}'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 25, right: 10),
                  leading: const Icon(
                    Icons.block,
                    color: Color(0xFFF15C6D),
                  ),
                  title: Text(
                    'Block ${user.userName}',
                    style: const TextStyle(
                      color: Color(0xFFF15C6D),
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 25, right: 10),
                  leading: const Icon(
                    Icons.thumb_down,
                    color: Color(0xFFF15C6D),
                  ),
                  title: Text(
                    'Report ${user.userName}',
                    style: const TextStyle(
                      color: Color(0xFFF15C6D),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  iconWithText({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: Coolors.greenDark,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 20, color: Coolors.greenDark),
          ),
        ],
      ),
    );
  }
}

class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final UserModel user;
  final double maxHeaderHeight = 180;
  final double minHeaderHeight = kToolbarHeight + 20;
  final double maxImageSize = 130;
  final double minImageSize = 40;

  SliverPersistentDelegate(this.user);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final percent = shrinkOffset / (maxHeaderHeight - 35);
    final percentnext = shrinkOffset / (maxHeaderHeight);
    final currentImageSize =
        (maxImageSize * (1 - percent)).clamp(minImageSize, maxImageSize);
    final currentImagePosition = ((size.width / 2 - 65) * (1 - percent))
        .clamp(minImageSize, maxImageSize);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        color: Theme.of(context)
            .appBarTheme
            .backgroundColor!
            .withOpacity(percentnext * 2 < 1 ? percentnext * 2 : 1),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 15,
              left: currentImagePosition + 50,
              child: Text(
                user.userName,
                style: TextStyle(
                    fontSize: 20, color: Colors.white.withOpacity(percentnext)),
              ),
            ),
            Positioned(
                left: 0,
                top: MediaQuery.of(context).viewPadding.top + 5,
                child: BackButton(
                    color: percentnext > .3
                        ? Colors.white.withOpacity(percentnext)
                        : null)),
            Positioned(
                right: 0,
                top: MediaQuery.of(context).viewPadding.top + 5,
                child: custom_icon_button(
                  onTap: () {},
                  icon: Icons.more_vert,
                  color: percentnext > .3
                      ? Colors.white.withOpacity(percentnext)
                      : Theme.of(context).textTheme.bodyMedium!.color,
                )),
            Positioned(
                left: currentImagePosition,
                bottom: 0,
                child: Hero(
                  tag: 'profile',
                  child: Container(
                    width: currentImageSize,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(user.profileImageUrl))),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderHeight;

  @override
  double get minExtent => minHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
