import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/helpers/show_alert_dialog.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';
import 'package:whatsapp/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp/features/auth/widgets/custom_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

sendCodeToPhone(){

final phoneNumber = phoneNumberController.text;
final countryName = countryNameController.text;
final countryCode = countryCodeController.text;

if(phoneNumber.isEmpty){
  return showAlertDialog(context: context, message: "Please enter your phone number");
}else if(phoneNumber.length <9){
  return showAlertDialog(context: context, message: "This number is too short for the country $countryName");
}else if(phoneNumber.length >10){
  return showAlertDialog(context: context, message: "This number is too long for the country $countryName");
}

print('+$countryCode$phoneNumber');

//request a verification code

ref.read(authControllerProvider).sendSmsCode(
  context: context,
   phoneNumber: '+$countryCode$phoneNumber');

}

  showCountryNamePicker() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        favorite: ['IN'],
        countryListTheme: CountryListThemeData(
          bottomSheetHeight: 600,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flagSize: 22,
          borderRadius: BorderRadius.circular(20),
          textStyle: TextStyle(color: context.theme.greyColor),
          inputDecoration: InputDecoration(
            labelStyle: TextStyle(color: context.theme.greyColor),
            prefixIcon: const Icon(
              Icons.language,
              color: Coolors.greenDark,
            ),
            hintText: 'search country code or name',
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: context.theme.greyColor!.withOpacity(0.2)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Coolors.greenDark),
            ),
          ),
        ),
        onSelect: (country) {
          countryNameController.text = country.name;
          countryCodeController.text = country.phoneCode;
        });
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'India');
    countryCodeController = TextEditingController(text: '91');
    phoneNumberController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            'Enter your phone Number',
            style: TextStyle(color: context.theme.authAppbarTextColor),
          ),
          centerTitle: true,
          actions: [
            custom_icon_button(onTap: () {  },icon: Icons.more_vert,)
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Whatsapp will now need to verify your phone number',
                    style:
                        TextStyle(color: context.theme.greyColor, height: 1.5),
                    children: [
                      TextSpan(
                          text: "  What's my number ? ",
                          style: TextStyle(
                            color: context.theme.blueColor,
                          )),
                    ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: CustomTextField(
                onTap: showCountryNamePicker,
                controller: countryNameController,
                readOnly: true,
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Coolors.greenDark,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: CustomTextField(
                      controller: countryCodeController,
                      onTap:showCountryNamePicker,
                      prefixText: '+',
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: CustomTextField(
                    controller: phoneNumberController,
                    hintText: 'Phone Number',
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Carrier charges may apply',
              style: TextStyle(color: context.theme.greyColor),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: custom_elevated_button(
            onPressed: sendCodeToPhone, 
            text: 'Next', buttonWidth: 90
            ));
  }
}
