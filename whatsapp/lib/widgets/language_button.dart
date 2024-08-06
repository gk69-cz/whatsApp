
import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';

class language_button extends StatelessWidget {
  const language_button({
    super.key,
  });
  showBottomSheet(context){
    return showModalBottomSheet(
      context: context,
      builder:(context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                  color: context.theme.greyColor!.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(height: 30,),
                    custom_icon_button(onTap: () => Navigator.of(context).pop(),icon: Icons.close_outlined,),
                    const SizedBox(height: 30,),
                    const Text('Language', 
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                       color: Coolors.greyDark
                    ),),

                  ],
                ),
                const SizedBox(height: 10,),
                Divider(
                  color: context.theme.greyColor!.withOpacity(.3),
                 thickness: .5,
                 ),
                 RadioListTile(
                  value: true,
                  groupValue: true,
                   onChanged: (value){},
                 activeColor: Coolors.greenDark,
                 title: const Text('English'),
                 subtitle: Text('Default Language',style: TextStyle(
                  color: context.theme.greyColor
                 ),),
                 ),
                  RadioListTile(
                  value: true,
                  groupValue: true,
                   onChanged: (value){},
                 activeColor: Coolors.greenDark,
                 title: const Text('عربي'),
                 subtitle: Text('Arabic',style: TextStyle(
                  color: context.theme.greyColor
                 ),),
                 )
            ],
          ),
        
        );
      },
     
    );

  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.theme.langBtnBgColor,
       
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
            onTap: ()=> showBottomSheet(context),
            borderRadius: BorderRadius.circular(20),
            splashFactory: NoSplash.splashFactory,
            highlightColor: context.theme.langBtnHighlightColor,
            child: const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.language,
                      color: Coolors.greenDark,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'English',
                      style: TextStyle(
                          color: Coolors.greenDark, 
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Coolors.greenDark,
                    ),
                  ]),
            )));
  }
}


