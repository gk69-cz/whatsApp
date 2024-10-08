import 'package:flutter/material.dart';
import 'package:whatsapp/common/routes/routes.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp/widgets/language_button.dart';
import 'package:whatsapp/widgets/privacy_and_terms.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  navigateToLoginPage(context){
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }


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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Image.asset("assets/images/circle.png",
                      color: context.theme.circleImageColor),
                ),
              )),
              Expanded(
                  child: Column(children: [
                const SizedBox(
                  height: 23,
                ),
                Text(
                  "Welcome to WhatsApp Clone",
                  style: TextStyle(
                      fontSize: 24,
                      color: context.theme.titleText,
                      fontWeight: FontWeight.bold),
                ),
                const privacy_policy(),
                custom_elevated_button(
                  onPressed: () => navigateToLoginPage(context),
                 
                  text: 'Agree and Continue',
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 200,
                    child: const language_button())
              ])),
            ]),
      ),
    );
  }
}
