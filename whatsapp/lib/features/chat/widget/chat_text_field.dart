import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart'; // Ensure the name of this widget is correct
import 'package:whatsapp/features/chat/controller/chat_controller.dart';

class ChatTextField extends ConsumerStatefulWidget {
  const ChatTextField({super.key, required this.recieverId});

  final String recieverId;

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {

  late TextEditingController messageContoller;
  bool isMessageEnabled = false;

  void sendTextMessage() async {
    if (isMessageEnabled) {
      ref.read(chatControllerProvider).sendTextMessage(
        context: context,
        textMessage: messageContoller.text,
        receiverId: widget.recieverId,
      );
      messageContoller.clear();
    }
  }

  @override
  void initState() {
    messageContoller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageContoller,
              maxLines: 4,
              minLines: 1,
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  isMessageEnabled = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(
                  color: context.theme.greyColor,
                ),
                filled: true,
                isDense: true,

                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
                prefixIcon: Material(
                  color: Colors.transparent,
                  child: custom_icon_button( // Ensure this is the correct widget name
                    onTap: () {},
                    icon: Icons.emoji_emotions_outlined,
                      color: context.theme.greyColor,
                  ),
                ),
                suffixIcon: !isMessageEnabled ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    RotatedBox(
                      quarterTurns: 45,
                      child: custom_icon_button(
                        onTap: () {},
                        icon: Icons.attach_file_outlined,
                        color: context.theme.greyColor,
                      ),
                    ),
                    custom_icon_button(
                      onTap: () {},
                      icon: Icons.camera_alt_outlined,
                      color: context.theme.greyColor,
                    ),
                  ],
                ): null,
                fillColor: context.theme.chatTextFieldBg, // Ensure this extension method is correct
              ),
            ),
          ),
          const SizedBox(width: 5),
          custom_icon_button(
            onTap: sendTextMessage,
            icon: isMessageEnabled ? Icons.send_outlined : Icons.mic_none_outlined,
         background: context.theme.authAppbarTextColor,
          ),
        ],
      ),
    );
  }
}
