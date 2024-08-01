
import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

class language_button extends StatelessWidget {
  const language_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.theme.langBtnBgColor,
       
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(20),
            splashFactory: NoSplash.splashFactory,
            highlightColor: context.theme.langBtnHighlightColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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


