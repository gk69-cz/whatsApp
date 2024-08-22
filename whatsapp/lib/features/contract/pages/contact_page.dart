import 'package:flutter/material.dart';
import 'package:whatsapp/common/widgets/custon_icon_button.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Column(
          children: [
            Text(
              ' Select Contact',
              style: TextStyle(color: Colors.white),
              
            ),
            SizedBox(height: 3,),
            Text('5 contact', style:TextStyle(
              fontSize: 12
            )),

         
            

          ],
        ),
           actions: [
          custom_icon_button(onTap: (){},icon: Icons.search,),
          custom_icon_button(onTap: (){},icon: Icons.more_vert,)
        ],

        
      ),
    );
  }
}
