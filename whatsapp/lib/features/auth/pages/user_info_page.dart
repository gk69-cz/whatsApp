import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';
import 'package:whatsapp/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp/features/auth/widgets/custom_text_field.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
   late TextEditingController UserNameController;

   @override
  void initState() {
    // TODO: implement initState
    
    UserNameController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    UserNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            'Profile Info',
            style: TextStyle(color: context.theme.authAppbarTextColor),
          ),
          centerTitle: true,
         
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Please provide your name and an optional profile photo', style: TextStyle(
              
                  color: context.theme.greyColor,
                )
              ),
              SizedBox(height: 40,),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.photoIconBgColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom:3, right:3),
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                  color: context.theme.photoIconColor,),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        textAlign: TextAlign.left,
                        autoFocus: true,
                        controller: UserNameController,
                        hintText: 'Type your name here',
                        )),
                        SizedBox(width: 10,),
                        Icon(
                          Icons.emoji_emotions_outlined,
                        color: context.theme.photoIconColor,),
                        SizedBox(width: 20,)
                  ],
                ),
              )
            ],
          ),
        ) ,
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: custom_elevated_button(
            onPressed: (){}, 
            text: 'Next', buttonWidth: 90
            ));
    
  }
}