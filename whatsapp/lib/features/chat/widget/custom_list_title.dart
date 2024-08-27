import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({super.key, required this.title, required this.leading, this.subtitle, this.trailing});

  final String title;
  final IconData leading;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListTile( 
        onTap: () {},
        contentPadding: EdgeInsets.fromLTRB(25, 5, 10, 5),
        title: Text(title),
        subtitle: subtitle != null ? Text(
          subtitle!,style: TextStyle(
          color: context.theme.greyColor
        ),): null,
        leading: Icon(leading),
        trailing: trailing,
      ),
    );
  }
}