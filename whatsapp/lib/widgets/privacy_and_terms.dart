
import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

class privacy_policy extends StatelessWidget {
  const privacy_policy({super.key, 

  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Center(
          child: RichText(
              text: TextSpan(
                  text: 'Read our ',
                  style: TextStyle(
                    color: context.theme.greyColor,
                    height: 1.5,
                  ),
                  children: [
                TextSpan(
                  text: 'Privacy Policy ',
                  style: TextStyle(
                    color:context.theme.blueColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: 'Tap "Agree and Continue" to accept the ',
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: context.theme.blueColor,
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
