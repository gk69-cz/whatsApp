import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

class custom_icon_button extends StatelessWidget {
  final VoidCallback onTap;
  final IconData? icon;
  final Color? color;
  final double? size;
  final double? minWidth;
  
  const custom_icon_button({
    super.key, required this.onTap, this.icon, this.color, this.size, this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        splashColor: Colors.transparent,
        splashRadius: 22,
        iconSize: size ?? 22,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: minWidth ?? 40),
        icon: Icon(
          icon,
          color: color ?? context.theme.greyColor,
        ));
  }
}
