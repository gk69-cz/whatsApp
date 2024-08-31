
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/models/user_model.dart';
import 'package:whatsapp/common/routes/routes.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';
import 'package:whatsapp/features/contract/controller/contact_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp/features/contract/widgets/ContactCard.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  void sendSms(String phoneNumber) async {
    Uri smsUri =
        Uri.parse("sms:$phoneNumber?body=Let's chat on new whatsapp");
    if (await launchUrl(smsUri)) {
    } else {}

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      // Handle the error if the SMS app cannot be launched
      print('Could not launch SMS app');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              ' Select Contact',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 3,
            ),
            ref.watch(contactControllerProvider).when(
              data: (allContacts) {
                return Text(
                  '${allContacts[0].isNotEmpty ? allContacts[0].length : 'No'} Contact ${allContacts[0].length > 1 ? 's' : ''}',
                  style: const TextStyle(fontSize: 14),
                );
              },
              error: (e, t) {
                return const Text(
                  'counting...',
                  style: TextStyle(fontSize: 12),
                );
              },
              loading: () {
                return const Text(
                  'counting...',
                  style: TextStyle(fontSize: 12),
                );
              },
            ),
          ],
        ),
        actions: [
          custom_icon_button(
            onTap: () {},
            icon: Icons.search,
          ),
          custom_icon_button(
            onTap: () {},
            icon: Icons.more_vert,
          )
        ],
      ),
      body: ref.watch(contactControllerProvider).when(data: (allContacts) {
        return ListView.builder(
            itemCount: allContacts[0].length + allContacts[1].length,
            itemBuilder: (context, index) {
              late UserModel firebaseContacts;
              late UserModel phoneContacts;

              if (index < allContacts[0].length) {
                firebaseContacts = allContacts[0][index];
              } else {
                phoneContacts = allContacts[1][index - allContacts[0].length];
              }
              return index < allContacts[0].length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(index == 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              theTile(leading: Icons.group, text: "New Group"),
                              theTile(leading: Icons.group, text: "New Contact",trailing: Icons.qr_code),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  'Contacts already on whatsapp',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: context.theme.greyColor),
                                ),
                              ),
                            ],
                          ),
                          ContactCard(
                              ContactScouce: firebaseContacts,
                               onTap: () {
                                Navigator.of(context).pushNamed(
                                  Routes.chat,arguments: firebaseContacts, );
                               })
                        ])
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == allContacts[0].length)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              'Contacts not on whatsapp',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: context.theme.greyColor),
                            ),
                          ),
                        ContactCard(
                            ContactScouce: phoneContacts,
                            onTap: () => sendSms(phoneContacts.phoneNumber))
                      ],
                    );
            });
      }, error: (e, t) {
        return null;
      }, loading: () {
        return Center(
            child: CircularProgressIndicator(
          color: context.theme.authAppbarTextColor,
        ));
      }),
    );
  }

  ListTile theTile(
      {required IconData leading, required String text, IconData? trailing}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 10, left: 20, right: 10),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Coolors.greenDark,
        child: Icon(
          leading,
          color: Colors.white,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        trailing,
        color: Coolors.greyDark,
      ),
    );
  }
}
