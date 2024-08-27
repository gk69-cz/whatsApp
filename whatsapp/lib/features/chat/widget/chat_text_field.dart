import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.recieverId});

  final String recieverId;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {

late TextEditingController messageContoller;
bool isMessageEnabled = false;
@override
  void initState() {
    messageContoller = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    messageContoller.dispose();
    // TODO: implement dispose
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
              onChanged: (value){
               value.isEmpty ? 
               setState(() {
                 isMessageEnabled = false;
               }):setState(() {
                 isMessageEnabled = true;
               });
              },
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(
                  color: context.theme.backgroundColor,                
                ),
                filled: true,
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    width: 0
                  ),

                ),
                prefixIcon: Material(
                  color: Colors.transparent,
                  child: custom_icon_button(onTap: (){},
                  icon: Icons.emoji_emotions_outlined,),
                ),
                suffixIcon: Row(children: [
                  RotatedBox(quarterTurns: 45,
                  child: custom_icon_button(onTap: (){},
                  icon: Icons.attach_file_outlined),),
                  custom_icon_button(onTap: (){},
                  icon: Icons.camera_alt_outlined),

                ],),
                fillColor: context.theme.ChatTextFieldBg,
              ),
            
            ),
          
          ),
          SizedBox(width: 5,),
          custom_icon_button(onTap: (){},
          icon: isMessageEnabled ? Icons.send_outlined : Icons.mic_none_outlined,
          ),
        ],
      ),
    );
  }
}