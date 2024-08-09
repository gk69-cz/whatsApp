import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';
import 'package:whatsapp/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp/features/auth/widgets/custom_text_field.dart';

class VerificationPage extends ConsumerWidget {
  
  const VerificationPage(
    {super.key,
     required this.smsCodeId,
      required this.phoneNumber});
final String smsCodeId;
  final String phoneNumber;

void verifySmsCode(BuildContext context,WidgetRef ref,String smsCode){
  ref.read(authControllerProvider).verifySmsCode(context: context, smsCodeId: smsCodeId, smsCode: smsCode, mounted: true);
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Verify your number',
          style: TextStyle(
            color: context.theme.authAppbarTextColor,
          ),
        ),
        centerTitle: true,
        actions: [
          custom_icon_button(
            onTap: () {},
            icon: Icons.more_vert,
          )
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: context.theme.greyColor,
                height: 1.5,
              ),
              children: [
                const TextSpan(
                    text:
                        'You have tried to register +98765489 . Before requesting a call or sms with your code '),
                TextSpan(
                    text: ' Wrong number ?',
                    style: TextStyle(
                      color: context.theme.blueColor,
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90),
          child: CustomTextField(
            hintText: '- - -  - - -',
     
            fontSize: 30,
            autoFocus: true,
            keyboardType: TextInputType.number,
            onChanged: (value){
              if (value.length == 6) {
                return verifySmsCode(context, ref, value);
              }
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Enter the 6-digit code',
          style: TextStyle(color: context.theme.greyColor),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Icon(
                Icons.message,
                color: context.theme.greyColor,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                'Resend SMS',
                style: TextStyle(color: context.theme.greyColor),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(color: context.theme.blueColor!.withOpacity(.2)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Icon(
                Icons.phone,
                color: context.theme.greyColor,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                'Call Me',
                style: TextStyle(color: context.theme.greyColor),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
