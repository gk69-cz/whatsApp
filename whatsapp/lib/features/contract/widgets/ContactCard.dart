
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/common/models/user_model.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    Key? key,
    required this.ContactScouce,
    required this.onTap,
  }) : super(key: key);

  final UserModel ContactScouce;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding:
          const EdgeInsets.only(left: 20, top: 0, bottom: 0, right: 10),
      dense: true,
      leading: CircleAvatar(
          backgroundImage: ContactScouce.profileImageUrl.isNotEmpty
              ? CachedNetworkImageProvider(ContactScouce.profileImageUrl)
              : null,
          backgroundColor: context.theme.greyColor!.withOpacity(0.3),
          radius: 20,
          child: ContactScouce.profileImageUrl.isEmpty
              ? const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                )
              : null),
      title: Text(ContactScouce.username,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      subtitle: const Text(
        'Hey there iam using clone',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: ContactScouce.profileImageUrl.isEmpty
          ? TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(foregroundColor: Coolors.greenDark),
              child: const Text('INVITE'))
          : null,
    );
  }
}
