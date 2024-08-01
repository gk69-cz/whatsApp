import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp/widgets/language_button.dart';
import 'package:whatsapp/widgets/privacy_and_terms.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Image.asset("assets/images/circle.png",
                  color: context.theme.circleImageColor),
            ),
          )),
          Expanded(
              child:
                  Column(
                  
                     children: [
                      SizedBox(height: 23,),
            Text(
              "Welcome to WhatsApp Clone",
              style: TextStyle(
                  fontSize: 24, color: context.theme.titleText, fontWeight: FontWeight.bold),
            ),
            privacy_policy(),
            custom_elevated_button(
              onPressed: () {
                print(ThemeMode.system);
              },
              text: 'Agree and Continue',
            ),
            SizedBox(
              height: 30,
              
            ),
            SizedBox(
              width: 
               MediaQuery.of(context).size.width - 200,
              child: language_button())
          ])),
        ]),
      ),
    );
  }
}
